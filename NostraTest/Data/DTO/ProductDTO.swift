//
//  DTO.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

struct ReviewProductDTO: Codable {
    let rating: Int
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String
}

extension ReviewProductDTO {
    func toDomain() -> Review? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "UTC")

        guard let parsedDate = formatter.date(from: date) else {
            return nil
        }

        return Review(
            rating: rating,
            comment: comment,
            date: parsedDate,
            reviewerName: reviewerName,
            reviewerEmail: reviewerEmail
        )
    }
}

struct ProductDTO: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
    let reviews: [ReviewProductDTO]?
}

extension ProductDTO {
    func toDomain() -> Product {
        Product(
            id: id,
            title: title,
            description: description,
            price: price,
            discountPercentage: discountPercentage ?? 0,
            rating: rating ?? 0,
            stock: stock ?? 0,
            brand: brand,
            category: category ?? "Uncategorized",
            thumbnailURL: thumbnail.flatMap(URL.init(string:)),
            imageURLs: (images ?? []).compactMap(URL.init(string:)),
            reviews: (reviews ?? []).compactMap { $0.toDomain() }
        )
    }
}
