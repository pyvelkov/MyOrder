//
//  OrderCell.swift
//  Plamen_MyOrder
//
//  Created by Plamen Velkov on 2021-02-18.
//  Student# 046175139
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet var lblCoffeeType : UILabel!
    @IBOutlet var lblSize : UILabel!
    @IBOutlet var lblQuantity : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
