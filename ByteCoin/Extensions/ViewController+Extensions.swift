//
//  ViewController+Extensions.swift
//  ByteCoin
//
//  Created by Eldar Garbuzov on 21.02.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

//MARK: - PickerView Set
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currentCurrencySelected.text = currencyArray[row]
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = currencyArray[row]
        apiManager.getCoinPrice(for: selectedCurrency)
    }
}
//MARK: - set data from api manager to labels in VC
extension ViewController: CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.currentMoneyValueLabel.text = price
            self.currentCurrencySelected.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
