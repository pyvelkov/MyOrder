//
//  Orders.swift
//  Plamen_MyOrder
//
//  Created by Plamen Velkov on 2021-02-18.
//  Student# 046175139
//

import Foundation

struct Order{
    var coffeeType : String
    var size : String
    var quantity : Int32
    
    init() {
        self.coffeeType = ""
        self.size = ""
        self.quantity = 0
    }
    
    init(coffeeType : String, size : String, quantity : Int32){
        self.coffeeType = coffeeType
        self.size = size
        self.quantity = quantity
    }
}
