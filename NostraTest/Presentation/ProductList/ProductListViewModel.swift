//
//  ProductListViewModel.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

final class ProductListViewModel {
    private(set) var state: ProductListState = .loading {
        didSet { onStateChange?(state) }
    }
    
    var onStateChange: ((ProductListState) -> Void)?
    
    private let fetchProductsUseCase: FetchProductUseCase
    private(set) var products: [Product] = []
    
    init(fetchProductsUseCase: FetchProductUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    @MainActor
    func loadProducts() async {
        state = .loading
        do {
            let result = try await fetchProductsUseCase.execute()
            products = result
            state = result.isEmpty ? .empty : .loaded(result)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
