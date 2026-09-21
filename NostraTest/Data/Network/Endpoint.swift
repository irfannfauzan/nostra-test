//
//  Endpoint.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

enum Endpoint {
    case productList(limit: Int, skip: Int)
    case productDetail(id: Int)
    
    private static let baseURL = "https://dummyjson.com"
    
    func url() -> URL? {
        switch self {
            
        case.productList(let limit, let skip):
            var components = URLComponents(string: "\(Self.baseURL)/products")
            components?.queryItems = [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "skip", value: String(skip))
            ]
            return components?.url
            
        case.productDetail(let id):
            return URL(string: "\(Self.baseURL)/products/\(id)")
        }
    }
}
