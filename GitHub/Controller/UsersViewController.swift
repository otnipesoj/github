//
//  ViewController.swift
//  GitHub
//
//  Created by Jose Pinto on 04/12/2021.
//

import UIKit

protocol RefreshUsersDataDelegate: AnyObject {
    func refreshData()
}

class UsersViewController: DataLoadingViewController {
    
    enum Section { case main }
    
    var users: [User] = []
    
    var page = 1
    var hasMoreUsers = true
    var isSearching = false
    var isLoadingMoreUsers = false
    
    var timer: Timer?
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, User>!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Users"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getUsers(page: page)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureThreeColumnFlowLayout(in: view))
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, user) -> UICollectionViewCell? in
            let cell: UserCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.set(user: user)
            return cell;
        })
    }
    
    private func updateUI(with users: [User]) {
        if users.count < NetworkService.shared.pageSize { self.hasMoreUsers = false }
        self.users.append(contentsOf: users)
        
        if self.users.isEmpty {
            self.showEmptyStateView(with: "There is no users", in: self.view)
            return
        } else {
            self.dismissEmptyStateView()
            DispatchQueue.main.async { self.updateData(on: self.users) }
        }
    }
    
    private func updateData(on users: [User]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections([.main])
        snapshot.appendItems(users)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func getUsers(username: String? = nil, page: Int) {
        showLoadingView()
        isLoadingMoreUsers = true
        
        Task {
            do {
                let users = try await NetworkService.shared.searchUsers(by: username, page: page)
                updateUI(with: users)
                dismissLoadingView()
            } catch {
                if let ghError = error as? GHError, ghError == .rateLimitExceeded {
                    let alert = UIAlertController(title: "Error", message: ghError.rawValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
                
                updateUI(with: [])
                dismissLoadingView()
            }
        }
        
        isLoadingMoreUsers = false
    }
}

extension UsersViewController: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreUsers, !isLoadingMoreUsers else { return }
            page += 1
            getUsers(username: navigationItem.searchController?.searchBar.text, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = users[indexPath.item]
        let destinationViewController = UserInfoViewController()
        destinationViewController.username = user.login
        destinationViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: destinationViewController)
        present(navigationController, animated: true)
    }
}

extension UsersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            if searchText.isEmpty {
                if self.isSearching {
                    self.restartUsersLoad()
                }
                
                return
            }

            self.isSearching = true
            self.hasMoreUsers = true
            self.page = 1
            self.users.removeAll()
            self.collectionView.scrollToTop(animated: true)
            self.getUsers(username: searchText, page: self.page)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        restartUsersLoad()
    }
    
    private func restartUsersLoad() {
        self.isSearching = false
        self.hasMoreUsers = true
        self.page = 1
        self.users.removeAll()
        self.collectionView.scrollToTop(animated: true)
        self.getUsers(page: self.page)
    }
}

extension UsersViewController: RefreshUsersDataDelegate {
    func refreshData() {
        collectionView.reloadData()
    }
}
