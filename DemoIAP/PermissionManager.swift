//
//  PermissionManager.swift
//  DemoIAP
//
//  Created by Trịnh Xuân Minh on 14/11/2024.
//

import Foundation
import IAPManager

final class PermissionManager {
  static let shared = PermissionManager()
  
  @Published private(set) var isPremium = false
  @Published private(set) var onwerSkin = false
  @Published private(set) var credit = 0
}

extension PermissionManager {
  func unlock(permissions: [BasePermission]) {
    for permission in permissions {
      switch permission as! AppPermission {
      case .premium:
        self.isPremium = true
      case .skin:
        self.onwerSkin = true
      }
    }
  }
  
  func consumable(product: BaseProduct) {
    switch product as! AppProduct {
    case .skip5Ads:
      guard let value = product.value, let number = value["ads"] as? Int else {
        return
      }
      self.credit += number
    default:
      return
    }
  }
}
