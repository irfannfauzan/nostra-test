//
//  ProductRepositoryProtocol.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

protocol ProductRepositoryProtocol {
    func fetchProducts(limit: Int, skip: Int) async throws -> [Product]
}
