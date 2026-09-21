//
//  ProductRepository.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

final class ProductRepository: ProductRepositoryProtocol {
    private let apiClient: APIClientProtocol
    private let cache: ProductCacheProtocol

    init(apiClient: APIClientProtocol, cache: ProductCacheProtocol) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func fetchProducts(limit: Int, skip: Int) async throws -> [Product] {
        let cacheKey = "products_\(limit)_\(skip)"

        if let cached = cache.getProductList(key: cacheKey) {
            return cached
        }

        let response: ProductListResponseDTO = try await apiClient.get(.productList(limit: limit, skip: skip))
        let products = response.products.map { $0.toDomain() }
        cache.setProductList(products, key: cacheKey)
        return products
    }

    func fetchProductDetail(id: Int) async throws -> Product {
        if let cached = cache.getProductDetail(id: id) {
            return cached
        }

        let response: ProductDTO = try await apiClient.get(.productDetail(id: id))
        let product = response.toDomain()
        cache.setProductDetail(product)
        return product
    }
}
