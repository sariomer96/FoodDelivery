//
//  FoodDetail.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit
import SDWebImage

class FoodDetail: UIViewController {

 
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var food : Foods?
    var viewModel = FoodDetailViewModel()
    
    @IBOutlet weak var foodPriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        if let f = food {
           // print(f.yemek_adi!)
            setFoodImage(food: f)
            setFoodProperties(f: f)
        }
            
        
        
    }
    func setFoodImage(food:Foods){
        
    
        
            imageView.sd_setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)"), placeholderImage: UIImage(named: food.yemek_resim_adi!))
        
       
    }
    func setFoodProperties (f:Foods) {
        let yemek = f.yemek_adi
        print(yemek)
        foodName.text = yemek
        foodPriceLabel.text = f.yemek_fiyat
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
