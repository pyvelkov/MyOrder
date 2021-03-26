//
//  DatabaseHelper.swift
//  Plamen_MyOrder
//
//  Created by Plamen Velkov on 2021-03-26.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper{
    
    //singleton instance
    private static var shared : DatabaseHelper?
    
    static func getInstance() -> DatabaseHelper{
        if shared != nil{
            //instance already exists
            return shared!
        }else {
            //create new instance if it doesnt exist
            return DatabaseHelper(context: (UIApplication.shared.delegate as!
                                                AppDelegate).persistentContainer.viewContext)
        }
    }
    
    private let moc : NSManagedObjectContext
    
    private init(context : NSManagedObjectContext){
        self.moc = context
    }
}
