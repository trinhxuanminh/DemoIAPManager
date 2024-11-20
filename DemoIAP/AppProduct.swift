//
//  App.swift
//  DemoIAP
//
//  Created by Trịnh Xuân Minh on 14/11/2024.
//

import Foundation
import IAPManager

enum AppProduct: BaseProduct, CaseIterable {
  case weekly
  case monthly
  case yearly
  case skin
  case skip5Ads
  
  var id: String {
    switch self {
    case .weekly:
      return "cat.language.keyboard.diy.combine.weekly"
    case .monthly:
      return "cat.language.keyboard.diy.combine.monthly"
    case .yearly:
      return "cat.language.keyboard.diy.combine.yearly"
    case .skin:
      return "cat.language.keyboard.diy.combine.skin"
    case .skip5Ads:
      return "cat.language.keyboard.diy.combine.skip5ads"
    }
  }
  
  var title: String {
    switch self {
    case .weekly:
      return "Weekly"
    case .monthly:
      return "Monthly"
    case .yearly:
      return "Yearly"
    case .skin:
      return "Skin"
    case .skip5Ads:
      return "Skip 5 ads"
    }
  }
  
  var value: [String : Any]? {
    switch self {
    case .skip5Ads:
      return ["ads": 5]
    default:
      return nil
    }
  }
}
