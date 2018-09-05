//
//  Tipsy.swift
//  Tipsy
//
//  Created by Sabrina Ren on 2018-09-03.
//  Copyright © 2018 Sabrina Ren. All rights reserved.
//

import Foundation

class Tipsy {
    
    var tipAmount: Float = 0
    var givenBill: Float = 0
    var tipPct: Float = 0
    var totalNoSplit: Float = 0
    
    var splitNumber: Float = 1
    var totalWithSplit: Float = 0
    
    init(givenBill: Float, tipPct: Float) {
        self.givenBill = givenBill
        self.tipPct = tipPct
    }
    
    func calculateTip() {
        tipAmount = givenBill * tipPct
        totalNoSplit = givenBill + tipAmount
    }
    
    func calculateSplit() {
        totalWithSplit = totalNoSplit / splitNumber
    }

}
