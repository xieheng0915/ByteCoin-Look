//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit



class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var bitcoinValLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
       
       
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var coinManager = CoinManager()
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
    }


}

extension ViewController: CoinManagerDelegate {
   
    
    func didUpdateCurrency(currenyPrice: String, currency: String) {
        DispatchQueue.main.async{
            self.bitcoinValLbl.text = currenyPrice
            self.currencyLbl.text = currency
        }
    }
    
    func didFailWithError(_ coinManager: CoinManager, error: Error) {
        print(error)
    }
    

}
