//
//  HomeViewController.swift
//  Tipsy
//
//  Created by Sabrina Ren on 2018-09-03.
//  Copyright © 2018 Sabrina Ren. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var givenBillTextField: UITextField!
    @IBOutlet weak var tipPctLabel: UILabel!
    @IBOutlet weak var tipPctSlider: UISlider!
    @IBOutlet weak var totalNoSplitLabel: UILabel!
    @IBOutlet weak var tipTotalLabel: UILabel!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var splitSlider: UISlider!
    @IBOutlet weak var splitTotalLabel: UILabel!
    
    // MARK: - Properties
    
    var tipCalc = Tipsy(givenBill: 0, tipPct: 0.12)
    
    // clears text field upon edit
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        givenBillTextField.text = ""
    }
    
    // hides keyboard when 'return' key is hit
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == givenBillTextField {
            textField.resignFirstResponder()
            calculateTip()
            calculateSplit()
        }
        return true
    }
    
    // status bar properties
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        givenBillTextField.layer.borderWidth = 1
        givenBillTextField.layer.borderColor = UIColor.white.cgColor
        givenBillTextField.layer.cornerRadius = 6

        givenBillTextField.text = String(format: "%0.2f", arguments: [tipCalc.givenBill])
        tipPctLabel.text = String(format: "Tip %d%%", arguments: [Int(tipCalc.tipPct * 100)])
        splitNumberLabel.text = String(format: "Split: %01d", arguments: [Int(tipCalc.splitNumber)])
    }
    
    func calculateTip() {
        tipCalc.tipPct = Float(roundf(tipPctSlider.value * 100) / 100)
        tipCalc.givenBill = ((givenBillTextField.text)! as NSString).floatValue
        tipCalc.calculateTip()
        updateUI()
    }
    
    func calculateSplit() {
        tipCalc.splitNumber = Float(roundf(splitSlider.value * 1) / 1)
        tipCalc.calculateSplit()
        updateUI()
    }
    
    func updateUI() {
        totalNoSplitLabel.text = String(format: "Total: $%0.2f", arguments: [tipCalc.totalNoSplit])
        tipTotalLabel.text = String(format: "– Tip $%0.2f", arguments: [tipCalc.tipAmount])
        splitTotalLabel.text = String(format: "Each total: $%0.2f", arguments: [tipCalc.totalWithSplit])
    }
    
    // MARK: - UIControl Events
    
    @IBAction func billGivenTextFieldChanged(_ sender: Any) {
        calculateTip()
        calculateSplit()
    }
    
    @IBAction func tipPctSliderValueChanged(_ sender: Any) {
        tipPctLabel.text! = String(format: "Tip %02d%%", arguments: [Int(roundf(tipPctSlider.value * 100))])
        (sender as AnyObject).setValue(Float(roundf(tipPctSlider.value * 100) / 100), animated: true)
        calculateTip()
        calculateSplit()
    }
    
    @IBAction func splitSliderValueChanged(_ sender: Any) {
        splitNumberLabel.text! = String(format: "Split: %01d", arguments: [Int(roundf(splitSlider.value))])
        (sender as AnyObject).setValue(Float(roundf(splitSlider.value * 1) / 1), animated: true)
        calculateSplit()
    }
    
    @IBAction func reset(_ sender: Any) {
        tipCalc = Tipsy(givenBill: 0, tipPct: 0.12)
        viewDidLoad()
        updateUI()
        tipPctSlider.value = 0.12
        splitSlider.value = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
