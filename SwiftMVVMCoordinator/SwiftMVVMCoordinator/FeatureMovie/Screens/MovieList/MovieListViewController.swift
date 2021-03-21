//
//  MovieListViewController.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Combine
import UIKit

final class MovieListViewController: BaseViewController<MovieListViewModel> {
    
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var filterSegment: UISegmentedControl!
    @IBOutlet private weak var errorView: UIView!
    
    // MARK: Variables
    private var subscribers = Set<AnyCancellable>()
    var selectedRowIndexPath = PassthroughSubject<Int, Never>()
    var footerLinkTapped = PassthroughSubject<Void, Never>()
    var refreshControl = UIRefreshControl()
    
    // MARK: Life-cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = LocalizableKey.appTitle.rawValue.localized()
        
        setupViews()
        bindObservables()
        fetchMovieList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.checkActiveSegment()
    }
    
    private func setupViews() {
        setupTableView()
        setupRefreshControl()
    }
    
    private func setupTableView() {
        tableView.register(
            UINib(nibName: MovieTableViewCell.nibName, bundle: nil),
            forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier
        )
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupRefreshControl() {
        refreshControl.layer.zPosition = -1
        let refreshString = LocalizableKey.pullToRefresh.rawValue.localized()
        refreshControl.attributedTitle = NSAttributedString(string: refreshString)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        /// Reset segment before reload
        filterSegment.selectedSegmentIndex = 0
        fetchMovieList()
    }
    
    private func bindObservables() {
        viewModel.$filteredMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (response) in
                self?.reloadTableView()
            }.store(in: &subscribers)
        
        viewModel.error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (error) in
                self?.showErrorView(error: error)
            }.store(in: &subscribers)
        
        viewModel.$selectedFilterIndex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (selected) in
                self?.filterSegment.selectedSegmentIndex = selected.rawValue
            }.store(in: &subscribers)
    }
    
    private func fetchMovieList() {
        refreshControl.beginRefreshing()
        hideErrorView(completion: { [weak self] in
            self?.viewModel.fetchMovieList()
        })
    }
    
    @IBAction func filterSegmentValueChanged(_ sender: UISegmentedControl) {
        let filterType = MovieFilter(rawValue: filterSegment.selectedSegmentIndex)!
        viewModel.applyFilter(with: filterType)
    }
    
    @objc func didTapFooter() {
        footerLinkTapped.send()
    }
    
    @IBAction func didTapReload(_ sender: Any) {
        fetchMovieList()
    }
}

// MARK: TableView DataSource Methods
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.getCellViewModel(for: indexPath.item)
        
        let reuseIdentifier = MovieTableViewCell.reuseIdentifier
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MovieTableViewCell
        
        cell.configure(with: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredMovies.count
    }
    
    private func reloadTableView() {
        refreshControl.endRefreshing()
        let sections = NSIndexSet(indexesIn: NSMakeRange(0, tableView.numberOfSections))
        tableView.reloadSections(sections as IndexSet, with: .automatic)
    }
}

// MARK: TableView Delegate Methods
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndexPath.send(indexPath.item)
    }
}

// MARK: Table Error State
extension MovieListViewController {
    private func showErrorView(error: Error? = nil) {
        errorView.isHidden = false
        errorView.alpha = 1.0
        refreshControl.endRefreshing()
    }
    
    private func hideErrorView(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3) {
            self.errorView.alpha = 0
        } completion: { _ in
            self.errorView.isHidden = true
            completion?()
        }
    }
}
