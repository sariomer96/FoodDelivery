//
//  CartTableViewCell.swift
//  GraduationProject
//
//  Created by Omer on 16.10.2023.
//

import UIKit

class CartTableViewCell: UITableViewCell {
   
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var deleteClick: UIButton!
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
