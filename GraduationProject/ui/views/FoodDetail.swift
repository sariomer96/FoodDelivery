//
//  FoodDetail.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit

class FoodDetail: UIViewController {

    var food : Foods?
    var viewModel = FoodDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func addToCart(_ sender: Any) {
        viewModel.addToCart(yemek_adi: "Ayran", yemek_resim_adi: "ayran.png", yemek_fiyat: 3, yemek_siparis_adet: 4, kullanici_adi: "s_omer_sari")
    }
    
    

    @IBAction func getBasket(_ sender: Any) {
        viewModel.getCart()
    }
    

}
