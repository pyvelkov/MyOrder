//
//  Orders.swift
//  Plamen_MyOrder
//
//  Created by Plamen Velkov on 2021-02-18.
//

import Foundation

struct Order{
    var coffeeType : String
    var size : String
    var quantity : Int
    
    init() {
        self.coffeeType = ""
        self.size = ""
        self.quantity = 0
    }
    
    init(coffeeType : String, size : String, quantity : Int){
        self.coffeeType = coffeeType
        self.size = size
        self.quantity = quantity
    }
}
