//
//  SplashViewController.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let makeProductListViewController: () -> UIViewController

    private let iconContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.backgroundColor = AppColors.secondaryGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chair-icon")
        imageView.tintColor = AppColors.primaryGreen
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "FoodCart"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = AppColors.primaryGreen
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.text = "SPECIAL & DELICIOUS FOOD"
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.textColor = AppColors.primaryGray
        label.textAlignment = .center
        label.letterSpacing(2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let headlineContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let headlineLine1: UILabel = {
        let label = UILabel()
        label.text = "Get Fresh Food"
        label.font = .systemFont(ofSize: 36, weight: .heavy)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let highlightBar: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.primaryGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let headlineLine2: UILabel = {
        let label = UILabel()
        label.text = "Right Now"
        label.font = .systemFont(ofSize: 36, weight: .heavy)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = AppColors.primaryGreen
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Make an order", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = AppColors.primaryGreen
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(makeProductListViewController: @escaping () -> UIViewController) {
            self.makeProductListViewController = makeProductListViewController
            super.init(nibName: nil, bundle: nil)
        }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupConstraints()
        orderButton.addTarget(self, action: #selector(didTapOrder), for: .touchUpInside)
    }


    private func setupHierarchy() {
        view.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        view.addSubview(logoLabel)
        view.addSubview(taglineLabel)

        headlineContainer.addSubview(highlightBar)
        headlineContainer.addSubview(headlineLine1)
        headlineContainer.addSubview(headlineLine2)
        view.addSubview(headlineContainer)

        view.addSubview(descriptionLabel)
        view.addSubview(orderButton)
    }

    private func setupConstraints() {
        let safe = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            iconContainerView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 30),
            iconContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconContainerView.widthAnchor.constraint(equalToConstant: 80),
            iconContainerView.heightAnchor.constraint(equalToConstant: 80),

            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),

            logoLabel.topAnchor.constraint(equalTo: iconContainerView.bottomAnchor, constant: 16),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            taglineLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 4),
            taglineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            headlineContainer.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 150),
            headlineContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headlineContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            headlineLine1.topAnchor.constraint(equalTo: headlineContainer.topAnchor),
            headlineLine1.leadingAnchor.constraint(equalTo: headlineContainer.leadingAnchor),

            headlineLine2.topAnchor.constraint(equalTo: headlineLine1.bottomAnchor, constant: 2),
            headlineLine2.leadingAnchor.constraint(equalTo: headlineContainer.leadingAnchor),
            headlineLine2.bottomAnchor.constraint(equalTo: headlineContainer.bottomAnchor),

            highlightBar.leadingAnchor.constraint(equalTo: headlineLine2.leadingAnchor),
            highlightBar.trailingAnchor.constraint(equalTo: headlineLine2.trailingAnchor, constant: 8),
            highlightBar.bottomAnchor.constraint(equalTo: headlineLine2.bottomAnchor, constant: 2),
            highlightBar.heightAnchor.constraint(equalToConstant: 20),

            descriptionLabel.topAnchor.constraint(equalTo: headlineContainer.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            
            orderButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            orderButton.heightAnchor.constraint(equalToConstant: 52)
        ])

        headlineContainer.bringSubviewToFront(headlineLine2)
    }

    @objc private func didTapOrder() {
        let productView = makeProductListViewController()
        navigationController?.setViewControllers([productView], animated: true)
    }
}

private extension UILabel {
    func letterSpacing(_ spacing: CGFloat) {
        guard let currentText = self.text else { return }
        let attributedString = NSMutableAttributedString(string: currentText)
        attributedString.addAttribute(
            .kern,
            value: spacing,
            range: NSRange(location: 0, length: attributedString.length)
        )
        self.attributedText = attributedString
    }
}

