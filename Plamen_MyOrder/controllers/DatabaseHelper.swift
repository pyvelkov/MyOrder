//
//  DatabaseHelper.swift
//  Plamen_MyOrder
//
//  Created by Plamen Velkov on 2021-03-26.
//  Student# 046175139
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
    private let ENTITY_NAME = "Orders"
    
    private init(context : NSManagedObjectContext){
        self.moc = context
    }
    
    //insert
    func insertOrder(newOrder : Order){
        do{
            //try insert a new record/order
            let orderTobeAdded = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! Orders
            
            orderTobeAdded.coffeeType = newOrder.coffeeType
            orderTobeAdded.quantity = newOrder.quantity
            orderTobeAdded.size = newOrder.size
            orderTobeAdded.id = UUID()
            orderTobeAdded.order_date = Date()
            
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function,"Data inserted successfully")
            }
        }catch let error as NSError{
            print(#function, "Could not save the data \(error)")
        }
    }
    
    //search
    func searchOrder(orderID : UUID) -> Orders?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", orderID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            
            if result.count > 0{
                return result.first as? Orders
            }
            
        }catch let error as NSError{
            print("Unable to search the order \(error)")
        }
        return nil
    }
    
    //update
    func updateOrder(updatedOrder: Orders){
        let searchResult = self.searchOrder(orderID: updatedOrder.id! as UUID)
        
        if(searchResult != nil){
            do{
                let orderToUpdate = searchResult!
                
                orderToUpdate.quantity = updatedOrder.quantity
                
                try self.moc.save()
                print(#function, "Order updated successfully")
            }catch let error as NSError{
                print(#function, "Unable to search the order \(error)")
            }
        }
    }
    
    //delete
    func deleteOrder(orderID: UUID){
        let searchResult = self.searchOrder(orderID: orderID)
        
        if (searchResult != nil){
            do{
                self.moc.delete(searchResult!)
                try self.moc.save()
                
                print(#function, "Order deleted successfully")
            }catch let error as NSError{
                print("Unable to delete task \(error)")
            }
        }
    }
    
    //retrieve all orders
    func getAllOrders() -> [Orders]?{
        let fetchRequest = NSFetchRequest<Orders>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "order_date", ascending: false)]
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "fetched data : \(result)")
            return result as [Orders]
        }catch let error as NSError{
            print("Could not fetch data \(error) \(error.code)")
        }
        
        return nil
    }
}
