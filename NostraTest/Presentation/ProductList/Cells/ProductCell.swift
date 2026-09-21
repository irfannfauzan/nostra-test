//
//  Untitled.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import UIKit

final class ProductCell: UITableViewCell {

    static let reuseIdentifier = "ProductCell"

    var onFavoriteTapped: (() -> Void)?

    private let cardContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageProduct: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hero-previews")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sellerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textColor = AppColors.primaryGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = AppColors.primaryGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let orderButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Buy Now"
        config.baseBackgroundColor = AppColors.primaryGreen
        config.baseForegroundColor = .white
        config.cornerStyle = .fixed
        config.background.cornerRadius = 8
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 12, weight: .semibold)
            return outgoing
        }
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let priceButtonSpacer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = AppColors.primaryGreen
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "heart")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        button.addTarget(self, action: #selector(favoriteTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(favoriteTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        return button
    }()

    private lazy var priceRow: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceLabel, priceButtonSpacer, orderButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, sellerLabel, descriptionLabel, priceRow])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 4
        stack.setCustomSpacing(7, after: descriptionLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var cardStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageProduct, textStack])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onFavoriteTapped = nil
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        UIView.animate(withDuration: 0.15) {
            self.cardContainer.alpha = highlighted ? 0.7 : 1.0
        }
    }

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(cardContainer)
        cardContainer.addSubview(cardStack)

        imageProduct.isUserInteractionEnabled = true
        imageProduct.addSubview(favoriteButton)

        NSLayoutConstraint.activate([
            cardContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            imageProduct.widthAnchor.constraint(equalToConstant: 96),
            imageProduct.heightAnchor.constraint(equalToConstant: 96),

            favoriteButton.topAnchor.constraint(equalTo: imageProduct.topAnchor, constant: 6),
            favoriteButton.trailingAnchor.constraint(equalTo: imageProduct.trailingAnchor, constant: -6),

            cardStack.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 16),
            cardStack.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 16),
            cardStack.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -16),
            cardStack.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: -16),
        ])
    }

    @objc private func didTapFavorite() {
        onFavoriteTapped?()
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
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        sellerLabel.text = product.category.capitalized
        descriptionLabel.text = product.description
        priceLabel.text = String(format: "$%.2f", product.price)
    }
    
}
