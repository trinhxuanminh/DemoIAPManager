//
//  ViewController.swift
//  DemoIAP
//
//  Created by Trịnh Xuân Minh on 13/11/2024.
//

import UIKit
import Combine
import IAPManager

class ViewController: UIViewController {
  @IBOutlet weak var creditLabel: UILabel!
  @IBOutlet weak var skinLabel: UILabel!
  @IBOutlet weak var premiumLabel: UILabel!
  @IBOutlet weak var skip5Button: UIButton!
  @IBOutlet weak var skinButton: UIButton!
  @IBOutlet weak var weeklyButton: UIButton!
  @IBOutlet weak var monthlyButton: UIButton!
  @IBOutlet weak var yearlyButton: UIButton!
  
  @Published private var credit = 0
  private var subscriptions = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    binding()
    history()
  }
  
  private func binding() {
    PermissionManager.shared.$isPremium
      .receive(on: DispatchQueue.main)
      .sink { [weak self] isPremium in
        guard let self else {
          return
        }
        premiumLabel.text = isPremium ? "Premium" : "Normal"
      }.store(in: &subscriptions)
    
    PermissionManager.shared.$onwerSkin
      .receive(on: DispatchQueue.main)
      .sink { [weak self] onwerSkin in
        guard let self else {
          return
        }
        skinLabel.text = onwerSkin ? "Owner Skin" : "No Skin"
      }.store(in: &subscriptions)
    
    PermissionManager.shared.$credit
      .receive(on: DispatchQueue.main)
      .sink { [weak self] credit in
        guard let self else {
          return
        }
        creditLabel.text = "\(credit) credit"
      }.store(in: &subscriptions)
    
    ProductManager.shared.$products
      .receive(on: DispatchQueue.main)
      .sink { [weak self] products in
        guard let self else {
          return
        }
        skip5Button.setTitle("Purchase 5 skip \(String(describing: products[.skip5Ads]?.displayPrice))", for: .normal)
        
        skinButton.setTitle("Purchase skin \(String(describing: products[.skin]?.displayPrice))", for: .normal)
        
        weeklyButton.setTitle("Purchase weekly \(String(describing: products[.weekly]?.displayPrice))", for: .normal)
        
        monthlyButton.setTitle("Purchase monthly \(String(describing: products[.monthly]?.displayPrice))", for: .normal)
        
        yearlyButton.setTitle("Purchase yearly \(String(describing: products[.yearly]?.displayPrice))", for: .normal)
      }.store(in: &subscriptions)
  }
  
  @IBAction func purchase5Skip(_ sender: Any) {
    purchase(product: .skip5Ads)
  }
  
  @IBAction func purchaseSkin(_ sender: Any) {
    purchase(product: .skin)
  }
  
  @IBAction func purchaseWeekly(_ sender: Any) {
    purchase(product: .weekly)
  }
  
  @IBAction func purchaseMonthly(_ sender: Any) {
    purchase(product: .monthly)
  }
  
  @IBAction func purchaseYearly(_ sender: Any) {
    purchase(product: .yearly)
  }
}

extension ViewController {
  private func purchase(product: AppProduct) {
    Task {
      do {
        let result = try await IAPManager.shared.purchase(product)
        switch result.type {
        case .consumable:
          PermissionManager.shared.consumable(product: result.product)
        default:
          PermissionManager.shared.unlock(permissions: result.permissions)
        }
      } catch let error {
        switch error as? IAPManager.PurchaseError {
        default:
          print("Purchase:", product, error)
        }
      }
    }
  }
  
  private func history() {
    Task {
      let historys = await IAPManager.shared.historys()
      print("History:", historys)
    }
  }
}
