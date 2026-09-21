//
//  Cache.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

protocol ProductCacheProtocol {
    func getProductList(key: String) -> [Product]?
    func setProductList(_ products: [Product], key: String)
    func getProductDetail(id: Int) -> Product?
    func setProductDetail(_ product: Product)
}

final class ProductCache: ProductCacheProtocol {
    private struct Entry<T> {
        let value: T
        let storedAt: Date
    }

    private let ttl: TimeInterval
    private var listCache: [String: Entry<[Product]>] = [:]
    private var detailCache: [Int: Entry<Product>] = [:]

    init(ttl: TimeInterval = 60 * 5) {
        self.ttl = ttl
    }

    private func isExpired(_ storedAt: Date) -> Bool {
        Date().timeIntervalSince(storedAt) > ttl
    }

    func getProductList(key: String) -> [Product]? {
        guard let entry = listCache[key], !isExpired(entry.storedAt) else { return nil }
        return entry.value
    }

    func setProductList(_ products: [Product], key: String) {
        listCache[key] = Entry(value: products, storedAt: Date())
    }

    func getProductDetail(id: Int) -> Product? {
        guard let entry = detailCache[id], !isExpired(entry.storedAt) else { return nil }
        return entry.value
    }

    func setProductDetail(_ product: Product) {
        detailCache[product.id] = Entry(value: product, storedAt: Date())
    }
}
