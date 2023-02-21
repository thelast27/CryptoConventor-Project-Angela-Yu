//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currentCurrencySelected: UILabel!
    @IBOutlet weak var currentMoneyValueLabel: UILabel!
    
    var apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        apiManager.getCoinPrice(for: "USD")
    }
    
    
}

