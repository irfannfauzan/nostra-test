//
//  SplashViewController.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import UIKit
import SnapKit

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
        label.text = "e-Catalog"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = AppColors.primaryGreen
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.text = "DISCOVER PRODUCTS YOU'LL LOVE"
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
        label.text = "Find Everything"
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
        label.text = "You Need Today"
        label.font = .systemFont(ofSize: 36, weight: .heavy)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "From skincare essentials to home furniture and fragrances. Browse a curated catalog of everyday products, all in one place, updated in real time."
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
        view.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.view.alpha = 1
            }
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
       
           iconContainerView.snp.makeConstraints { make in
               make.top.equalTo(safe).offset(30)
               make.centerX.equalToSuperview()
               make.width.height.equalTo(80)
           }

           iconImageView.snp.makeConstraints { make in
               make.center.equalToSuperview()
               make.width.height.equalTo(48)
           }

           logoLabel.snp.makeConstraints { make in
               make.top.equalTo(iconContainerView.snp.bottom).offset(16)
               make.centerX.equalToSuperview()
           }

           taglineLabel.snp.makeConstraints { make in
               make.top.equalTo(logoLabel.snp.bottom).offset(4)
               make.centerX.equalToSuperview()
           }

           headlineContainer.snp.makeConstraints { make in
               make.top.equalTo(taglineLabel.snp.bottom).offset(150)
               make.leading.trailing.equalToSuperview().inset(24)
           }

           headlineLine1.snp.makeConstraints { make in
               make.top.leading.equalToSuperview()
           }

           headlineLine2.snp.makeConstraints { make in
               make.top.equalTo(headlineLine1.snp.bottom).offset(2)
               make.leading.equalToSuperview()
               make.bottom.equalToSuperview()
           }

           highlightBar.snp.makeConstraints { make in
               make.leading.equalTo(headlineLine2)
               make.trailing.equalTo(headlineLine2).offset(8)
               make.bottom.equalTo(headlineLine2).offset(2)
               make.height.equalTo(20)
           }

           descriptionLabel.snp.makeConstraints { make in
               make.top.equalTo(headlineContainer.snp.bottom).offset(20)
               make.leading.trailing.equalToSuperview().inset(24)
           }

           orderButton.snp.makeConstraints { make in
               make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
               make.leading.trailing.equalToSuperview().inset(24)
               make.height.equalTo(52)
           }

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

