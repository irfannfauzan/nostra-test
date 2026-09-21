//
//  FetchProductUseCase.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

final class FetchProductUseCase {
    private let repository : ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(limit: Int = 20, skip: Int = 0) async throws -> [Product] {
        try await repository.fetchProducts(limit: limit, skip: skip)
    }
}
