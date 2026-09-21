//
//  DetailProductViewController.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import UIKit

class DetailProductViewController: UIViewController {

    private let viewModel: DetailProductViewModel

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageProduct: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "detail-hero")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sellerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = AppColors.primaryGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = AppColors.primaryGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = AppColors.secondaryGreen
        config.baseForegroundColor = AppColors.primaryGreen
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "heart")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
        config.contentInsets = NSDirectionalEdgeInsets(top: 11, leading: 11, bottom: 11, trailing: 11)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        button.addTarget(self, action: #selector(favoriteTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(favoriteTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        return button
    }()

    private let titleRowSpacer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()

    private lazy var titleRow: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, titleRowSpacer, favoriteButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let thumbnailImageNames = ["hero-previews", "hero-previews", "hero-previews"]

    private let thumbnailsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var thumbnailsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let reviewsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Reviews"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let reviewsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var reviewsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let bottomBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let priceNavbar: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let spaceNavbar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()

    private let buttonBuy: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = AppColors.primaryGreen
        config.baseForegroundColor = .white
        config.cornerStyle = .fixed
        config.background.cornerRadius = 12
        config.title = "Buy Now"
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 46, bottom: 14, trailing: 46)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 16, weight: .semibold)
            return outgoing
        }
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var stackNavbar: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceNavbar, spaceNavbar, buttonBuy])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    init(viewModel: DetailProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(scrollView)
        view.addSubview(bottomBarView)
        view.addSubview(loadingIndicator)
        view.addSubview(statusLabel)
        bottomBarView.addSubview(separatorLine)
        bottomBarView.addSubview(stackNavbar)

        scrollView.addSubview(contentView)

        contentView.addSubview(imageProduct)
        contentView.addSubview(titleRow)
        contentView.addSubview(sellerLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(thumbnailsScrollView)
        contentView.addSubview(reviewsTitleLabel)
        contentView.addSubview(reviewsScrollView)

        thumbnailsScrollView.addSubview(thumbnailsStack)
        thumbnailImageNames.forEach { name in
            thumbnailsStack.addArrangedSubview(makeThumbnail(named: name))
        }

        reviewsScrollView.addSubview(reviewsStack)

        let safe = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safe.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomBarView.topAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            imageProduct.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageProduct.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            titleRow.topAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: 30),
            titleRow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            sellerLabel.topAnchor.constraint(equalTo: titleRow.bottomAnchor, constant: 4),
            sellerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            sellerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            descriptionLabel.topAnchor.constraint(equalTo: sellerLabel.bottomAnchor, constant: 14),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            thumbnailsScrollView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            thumbnailsScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailsScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailsScrollView.heightAnchor.constraint(equalToConstant: 64),

            thumbnailsStack.topAnchor.constraint(equalTo: thumbnailsScrollView.contentLayoutGuide.topAnchor),
            thumbnailsStack.leadingAnchor.constraint(equalTo: thumbnailsScrollView.contentLayoutGuide.leadingAnchor, constant: 24),
            thumbnailsStack.trailingAnchor.constraint(equalTo: thumbnailsScrollView.contentLayoutGuide.trailingAnchor, constant: -24),
            thumbnailsStack.bottomAnchor.constraint(equalTo: thumbnailsScrollView.contentLayoutGuide.bottomAnchor),
            thumbnailsStack.heightAnchor.constraint(equalTo: thumbnailsScrollView.frameLayoutGuide.heightAnchor),

            reviewsTitleLabel.topAnchor.constraint(equalTo: thumbnailsScrollView.bottomAnchor, constant: 24),
            reviewsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            reviewsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            reviewsScrollView.topAnchor.constraint(equalTo: reviewsTitleLabel.bottomAnchor, constant: 12),
            reviewsScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            reviewsScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            reviewsScrollView.heightAnchor.constraint(equalToConstant: 130),

            reviewsStack.topAnchor.constraint(equalTo: reviewsScrollView.contentLayoutGuide.topAnchor),
            reviewsStack.leadingAnchor.constraint(equalTo: reviewsScrollView.contentLayoutGuide.leadingAnchor, constant: 24),
            reviewsStack.trailingAnchor.constraint(equalTo: reviewsScrollView.contentLayoutGuide.trailingAnchor, constant: -24),
            reviewsStack.bottomAnchor.constraint(equalTo: reviewsScrollView.contentLayoutGuide.bottomAnchor),
            reviewsStack.heightAnchor.constraint(equalTo: reviewsScrollView.frameLayoutGuide.heightAnchor),

            reviewsScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),

            bottomBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackNavbar.topAnchor.constraint(equalTo: bottomBarView.topAnchor, constant: 24),
            stackNavbar.leadingAnchor.constraint(equalTo: bottomBarView.leadingAnchor, constant: 24),
            stackNavbar.trailingAnchor.constraint(equalTo: bottomBarView.trailingAnchor, constant: -24),
            stackNavbar.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -24),

            separatorLine.topAnchor.constraint(equalTo: bottomBarView.topAnchor),
            separatorLine.leadingAnchor.constraint(equalTo: bottomBarView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: bottomBarView.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])

        bindViewModel()
        Task { await viewModel.loadDetail() }
    }

    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }
    }

    private func render(_ state: DetailProductState) {
        switch state {
        case .loading:
            scrollView.isHidden = true
            bottomBarView.isHidden = true
            statusLabel.isHidden = true
            loadingIndicator.startAnimating()
        case .loaded(let product):
            loadingIndicator.stopAnimating()
            statusLabel.isHidden = true
            scrollView.isHidden = false
            bottomBarView.isHidden = false
            populate(with: product)
        case .error(let message):
            loadingIndicator.stopAnimating()
            scrollView.isHidden = true
            bottomBarView.isHidden = true
            statusLabel.isHidden = false
            statusLabel.text = message
        }
    }

    private func populate(with product: Product) {
        titleLabel.text = product.title
        sellerLabel.text = product.brand ?? product.category.capitalized
        descriptionLabel.text = product.description
        priceNavbar.text = product.formattedPrice

        reviewsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        product.reviews.forEach { review in
            reviewsStack.addArrangedSubview(makeReviewCard(for: review))
        }
    }

    @objc private func didTapFavorite() {
        print("tap favorite")
    }

    @objc private func favoriteTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.favoriteButton.alpha = 0.5
        }
    }

    @objc private func favoriteTouchUp() {
        UIView.animate(withDuration: 0.1) {
            self.favoriteButton.alpha = 1.0
        }
    }

    private func makeThumbnail(named imageName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return imageView
    }

    private func makeReviewCard(for review: Review) -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor.systemGray6
        card.layer.cornerRadius = 12
        card.translatesAutoresizingMaskIntoConstraints = false
        card.widthAnchor.constraint(equalToConstant: 220).isActive = true

        let nameLabel = UILabel()
        nameLabel.text = review.reviewerName
        nameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        let commentLabel = UILabel()
        commentLabel.text = review.comment
        commentLabel.font = .systemFont(ofSize: 11, weight: .regular)
        commentLabel.textColor = AppColors.primaryGray
        commentLabel.numberOfLines = 3
        commentLabel.translatesAutoresizingMaskIntoConstraints = false

        let ratingLabel = UILabel()
        ratingLabel.text = "Rating: \(review.rating)"
        ratingLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        ratingLabel.textColor = AppColors.primaryGreen
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false

        let textStack = UIStackView(arrangedSubviews: [nameLabel, commentLabel, ratingLabel])
        textStack.axis = .vertical
        textStack.spacing = 6
        textStack.translatesAutoresizingMaskIntoConstraints = false

        card.addSubview(textStack)
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: card.topAnchor, constant: 12),
            textStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -12),
            textStack.bottomAnchor.constraint(lessThanOrEqualTo: card.bottomAnchor, constant: -12),
        ])

        return card
    }
}
