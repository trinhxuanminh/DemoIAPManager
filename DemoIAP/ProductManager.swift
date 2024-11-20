//
//  ProductManager.swift
//  DemoIAP
//
//  Created by Trịnh Xuân Minh on 15/11/2024.
//

import Foundation
import StoreKit
import IAPManager

class ProductManager {
  static let shared = ProductManager()
  
  @Published private(set) var products: [AppProduct: Product] = [:]
  @Published private(set) var isLoading = false
  
  func fetch() {
    load()
  }
}

extension ProductManager {
  private func load() {
    Task {
      self.isLoading = true
      
      for product in AppProduct.allCases {
        do {
          let skProduct = try await IAPManager.shared.retrieveInfo(product: product)
          self.products[product] = skProduct
        } catch let error {
          print("Retrieve Info:", product, error)
        }
      }
      
      self.isLoading = false
    }
  }
}
