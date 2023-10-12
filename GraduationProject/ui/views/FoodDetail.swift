//
//  FoodDetail.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit
import SDWebImage

class FoodDetail: UIViewController {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var food : Foods?
    var viewModel = FoodDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(food?.yemek_resim_adi)
        if let f = food {
            
            print(f.yemek_resim_adi)
            
            imageView.sd_setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi!)"), placeholderImage: UIImage(named: f.yemek_resim_adi!))
            
          
        }
        
    }
    
    @IBAction func backToHome(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: nil)
        
    }
    
    @IBAction func addToCart(_ sender: Any) {

        
        viewModel.addToCart(yemek_adi: "Fanta", yemek_resim_adi: "fanta.png", yemek_fiyat: 6, yemek_siparis_adet:10, kullanici_adi: "s_omer_sari")
    }
    
    

    @IBAction func getBasket(_ sender: Any) {
        viewModel.getCart(kullanici_adi: "s_omer_sari")
    }
    

}
