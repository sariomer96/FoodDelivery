//
//  CollectionViewCell.swift
//  GraduationProject
//
//  Created by Omer on 11.10.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelFiyat: UILabel!
    
    @IBOutlet weak var labelUrunAdi: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }

       private func commonInit() {
         
           self.layer.borderWidth = 2.0
           self.layer.borderColor = UIColor.lightGray.cgColor
         
       }
}
