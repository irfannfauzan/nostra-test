//
//  DetailProductViewModel.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

final class DetailProductViewModel {
    private(set) var state: DetailProductState = .loading {
        didSet { onStateChange?(state) }
    }
    
    var onStateChange: ((DetailProductState) -> Void)?
    
    private let fetchProductDetail: FetchProductDetailUseCase
    private let productId: Int
    
    init(productId: Int, fetchProductDetail: FetchProductDetailUseCase) {
        self.productId = productId
        self.fetchProductDetail = fetchProductDetail
    }
    
    @MainActor
    func loadDetail() async {
        state = .loading
        do {
            let product = try await fetchProductDetail.execute(id: productId)
            state = .loaded(product)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
