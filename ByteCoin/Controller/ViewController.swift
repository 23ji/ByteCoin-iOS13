//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: UI
  
  @IBOutlet weak var bitCoinLabel: UILabel!
  @IBOutlet weak var currencyLabel: UILabel!
  @IBOutlet weak var currencyPicker: UIPickerView!
  
  var coinManager = CoinManager()
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.currencyPicker.dataSource = self
    self.currencyPicker.delegate = self
    self.coinManager.delegate = self
  }
}


// MARK: UIPickerView

extension ViewController: UIPickerViewDataSource{
  func numberOfComponents(in pickerView: UIPickerView) -> Int { //colum 수
    1 //한 줄 시 리턴 생략 가능
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { //row 수
    self.coinManager.currencyArray.count
  }
}

extension ViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    // row -> 0부터 호출
    self.coinManager.currencyArray[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.coinManager.getCoinPrice(for: self.coinManager.currencyArray[row])
  }
}

extension ViewController: CoinManagerDelegate {
  func didUpdatePrice(price: String, currency: String) {
    DispatchQueue.main.async {
      self.currencyLabel.text = currency
      self.bitCoinLabel.text = price
    }
  }
}
