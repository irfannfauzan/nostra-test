//
//  FetchProductUseCase.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

final class FetchProductDetailUseCase {
    private let repository : ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> Product {
        try await repository.fetchProductDetail(id: id)
    }
}
