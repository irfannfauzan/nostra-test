//
//  ProductList.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import UIKit

final class ProductListViewController: UIViewController {
    
    //dummy array of products
    private let products = [
        Product(title: "Lounge Sofa 1", category: "beauty", description: "Elegant mid-century modern sofa with plush cushions", price: 245.00),
        Product(title: "Lounge Sofa 2", category: "beauty", description: "Elegant mid-century modern sofa with plush cushions 3", price: 245.00),
        Product(title: "Lounge Sofa 4", category: "beauty", description: "Elegant mid-century modern sofa with plush cushions", price: 245.00),
        Product(title: "Lounge Sofa 5", category: "beauty", description: "Elegant mid-century modern sofa with plush cushions", price: 245.00),
        Product(title: "Lounge Sofa 6", category: "beauty", description: "Elegant mid-century modern sofa with plush cushions", price: 245.00)
    ]

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAppBar()
        setupTableView()
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
}


extension ProductListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductCell.reuseIdentifier,
            for: indexPath
        ) as? ProductCell else {
            return UITableViewCell()
        }

        let product = products[indexPath.row]
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
