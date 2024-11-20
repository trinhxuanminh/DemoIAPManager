//
//  AppPermission.swift
//  DemoIAP
//
//  Created by Trịnh Xuân Minh on 14/11/2024.
//

import Foundation
import IAPManager

enum AppPermission: BasePermission, CaseIterable {
  case premium
  case skin
  
  var products: [BaseProduct] {
    switch self {
    case .premium:
      return [AppProduct](arrayLiteral: .weekly, .monthly, .yearly)
    case .skin:
      return [AppProduct](arrayLiteral: .skin)
    }
  }
}
