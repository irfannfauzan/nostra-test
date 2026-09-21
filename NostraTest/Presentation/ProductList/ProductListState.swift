//
//  ProductListState.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

enum ProductListState {
    case loading
    case loaded([Product])
    case empty
    case error(String)
}
