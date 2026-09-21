//
//  ProductList.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import UIKit

final class ProductListViewController: UIViewController {

    private let viewModel: ProductListViewModel

    private let tableView = UITableView()

    private let appBarTitle: UILabel = {
        let label = UILabel()
        label.text = "Best Furniture"
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let appBarSubtitle: UILabel = {
        let label = UILabel()
        label.text = "Perfect Furniture"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = AppColors.primaryGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = AppColors.primaryGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAppBar()
        setupTableView()
        setupStatusViews()
        bindViewModel()
        Task { await viewModel.loadProducts() }
    }

    private func setupAppBar() {
        view.addSubview(appBarTitle)
        view.addSubview(appBarSubtitle)

        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            appBarTitle.topAnchor.constraint(equalTo: safe.topAnchor),
            appBarTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            appBarTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),

            appBarSubtitle.topAnchor.constraint(equalTo: appBarTitle.bottomAnchor, constant: 8),
            appBarSubtitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            appBarSubtitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
        ])
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: appBarSubtitle.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupStatusViews() {
        view.addSubview(loadingIndicator)
        view.addSubview(statusLabel)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }

    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }
    }

    private func render(_ state: ProductListState) {
        switch state {
        case .loading:
            tableView.isHidden = true
            statusLabel.isHidden = true
            loadingIndicator.startAnimating()
        case .loaded:
            loadingIndicator.stopAnimating()
            statusLabel.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        case .empty:
            loadingIndicator.stopAnimating()
            tableView.isHidden = true
            statusLabel.isHidden = false
            statusLabel.text = "Belum ada produk tersedia."
        case .error(let message):
            loadingIndicator.stopAnimating()
            tableView.isHidden = true
            statusLabel.isHidden = false
            statusLabel.text = message
        }
    }
}


extension ProductListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductCell.reuseIdentifier,
            for: indexPath
        ) as? ProductCell else {
            return UITableViewCell()
        }

        let product = viewModel.products[indexPath.row]
        cell.configure(with: product)
        cell.onFavoriteTapped = { [weak self] in
            self?.toggleFavorite(for: product)
        }
        return cell
    }
}


extension ProductListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DetailProductViewController()
        detailView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailView, animated: true)
    }

}


private extension ProductListViewController {
    func toggleFavorite(for product: Product) {
        print("tap favoritee!")
    }
}
