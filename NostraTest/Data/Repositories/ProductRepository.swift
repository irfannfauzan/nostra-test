//
//  ProductRepository.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

final class ProductRepository: ProductRepositoryProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchProducts(limit: Int, skip: Int) async throws -> [Product] {
        let response: ProductListResponseDTO = try await apiClient.get(.productList(limit: limit, skip: skip))
        return response.products.map { $0.toDomain() }
    }
    
    func fetchProductDetail(id: Int) async throws -> Product {
        let response: ProductDTO = try await apiClient.get(.productDetail(id: id))
        return response.toDomain()
    }
    
}
