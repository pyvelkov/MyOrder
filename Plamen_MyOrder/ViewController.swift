//
//  ViewController.swift
//  Plamen_MyOrder
//
//  Created by Plamen Velkov on 2021-02-14.
//  Student # 046175139
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tfQuantity : UITextField!
    @IBOutlet var segSize : UISegmentedControl!
    @IBOutlet var pkrCoffeeType : UIPickerView!
    
    let coffeeTypeList = ["Dark Roast", "Original Blend", "Vanilla", "Espresso", "Americano", "Cappuccino", "Mocha", "Macchiato"]
    
    private let dbHelper = DatabaseHelper.getInstance()
    
    var allOrders : [Orders] = [Orders]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.pkrCoffeeType.dataSource = self
        self.pkrCoffeeType.delegate = self
        
        let btnOrders = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(goToOrders))
        
        self.navigationItem.setRightBarButton(btnOrders, animated: true)
        
    }
    
    @IBAction func submitOrder() {
        if (!self.tfQuantity.text!.isEmpty){
            
            let quantity = Int32(self.tfQuantity.text!)!
            let size = self.segSize.titleForSegment(at: self.segSize.selectedSegmentIndex)!
            let coffeeType = self.coffeeTypeList[self.pkrCoffeeType.selectedRow(inComponent: 0)]
            let newOrder = Order(coffeeType: coffeeType, size: size, quantity: quantity)
            
            self.dbHelper.insertOrder(newOrder : newOrder)
            
            
            //allOrders.append(newOrder)
        }else {
            let alert = UIAlertController(title: "Error", message: "Please enter Quantity!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc
    func goToOrders(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let orderVC = storyboard.instantiateViewController(identifier: "TableView") as! OrdersTableViewController
        
        //orderVC.allOrders = allOrders
        
        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.coffeeTypeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coffeeTypeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
}
