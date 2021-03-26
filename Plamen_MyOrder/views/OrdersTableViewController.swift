//
//  OrdersTableViewController.swift
//  Plamen_MyOrder
//
//  Created by Plamen Velkov on 2021-02-18.
//  Student# 046175139
//

import UIKit

class OrdersTableViewController: UITableViewController {

    var allOrders : [Orders] = [Orders]()
    
    private let dbHelper = DatabaseHelper.getInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetch all the records and display in tableView
        self.fetchAllOrders()

        self.tableView.rowHeight = 75
        
        self.setUpLongPressGesture()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.allOrders.count
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(indexPath.row < self.allOrders.count){
            self.deleteOrderFromList(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_order", for: indexPath) as! OrderCell

        // Configure the cell...
        if indexPath.row < allOrders.count{
            cell.lblCoffeeType.text = allOrders[indexPath.row].coffeeType
            cell.lblSize.text = allOrders[indexPath.row].size
            cell.lblQuantity.text = String(allOrders[indexPath.row].quantity)
        }

        return cell
    }
    
    private func deleteOrderFromList(indexPath: IndexPath){
        self.dbHelper.deleteOrder(orderID: self.allOrders[indexPath.row].id!)
        self.fetchAllOrders()
    }
    
    private func updateOrderInList(indexPath: IndexPath, quantity: Int32){
        self.allOrders[indexPath.row].quantity = quantity
        
        self.dbHelper.updateOrder(updatedOrder: self.allOrders[indexPath.row])
        self.fetchAllOrders()
    }
    
    private func setUpLongPressGesture(){
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        
        longPressGesture.minimumPressDuration = 1.0 //1 second
        
        self.tableView.addGestureRecognizer(longPressGesture)
    
    }
    
    @objc
    private func handleLongPress(_ gestureRecognizer : UILongPressGestureRecognizer){
        if gestureRecognizer.state == .ended{
            let touchPoint = gestureRecognizer.location(in: self.tableView)
            
            if let indexPath = self.tableView.indexPathForRow(at: touchPoint){
                let alert = UIAlertController(title: "Update number of cups", message: "Do you want to update the quantity of coffee cups?", preferredStyle: .alert)
                
                alert.addTextField{(textField: UITextField) in
                    textField.text = String(self.allOrders[indexPath.row].quantity)
                    textField.keyboardType = .numberPad
                }
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                    if let newQuantity = alert.textFields?[0].text{
                        let quantity = Int32(newQuantity)
                        self.updateOrderInList(indexPath: indexPath, quantity: quantity!)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    private func fetchAllOrders(){
        if (self.dbHelper.getAllOrders() != nil){
            self.allOrders = self.dbHelper.getAllOrders()!
            self.tableView.reloadData()
        }else {
            print(#function, "No data received from dbHelper")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
