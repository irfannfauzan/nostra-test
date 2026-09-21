//
//  Entities.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

struct Review: Equatable, Hashable, Codable {
    let rating: Int
    let comment: String
    let date: Date
    let reviewerName: String
    let reviewerEmail: String
}

struct Product: Equatable, Hashable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String?
    let category: String
    let thumbnailURL: URL?
    let imageURLs: [URL]
    let reviews: [Review]

    var formattedPrice: String {
        String(format: "$%.2f", price)
    }

    var isOutOfStock: Bool {
        stock <= 0
    }
}
