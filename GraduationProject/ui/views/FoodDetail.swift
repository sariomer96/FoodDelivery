//
//  FoodDetail.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit
import SDWebImage

class FoodDetail: UIViewController {

    
    @IBOutlet weak var foodCountLabel: UILabel!
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var food : Foods?
    var viewModel = FoodDetailViewModel()
    var foodCount = 1
    var foodPrice = 0
    var basketList = [BasketFoods]()
    @IBAction func stepperClicked(_ sender: UIStepper) {
        foodCountLabel.text = String(Int(sender.value))
        foodCount = Int(sender.value)
        let totalPrice = Int(sender.value) * Int((food?.yemek_fiyat)!)!
        foodPrice = totalPrice
       foodPriceLabel.text = String(totalPrice)
        
    }
    @IBOutlet weak var foodPriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getCart(kullanici_adi: "s_omer_sari")
        _ = viewModel.basketList.subscribe(onNext: {  list in
            self.basketList = list
        
              
        })
        if let f = food {
          
            foodPrice = Int(f.yemek_fiyat!)!
            setFoodImage(food: f)
            setFoodProperties(f: f)
        }
            
        
        
    }
    func setFoodImage(food:Foods){

        imageView.sd_setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)"), placeholderImage: UIImage(named: food.yemek_resim_adi!))
    
    }
    func setFoodProperties (f:Foods) {
        let yemek = f.yemek_adi
      
        foodName.text = yemek
        foodPriceLabel.text = f.yemek_fiyat
    }
    
    @IBAction func backToHome(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: nil)
        
    }
    
    @IBAction func addToCart(_ sender: Any) {

        
        if let food = food {
            
            print(basketList.count)
            for i in basketList {
             
                if i.yemek_adi == food.yemek_adi {
                
                  
                    viewModel.updateCart(sepet_id: Int(i.sepet_yemek_id!)!, yemek_adi: i.yemek_adi!, yemek_resim_adi: i.yemek_resim_adi!, yemek_fiyat: Int(i.yemek_fiyat!)!, yemek_siparis_adet: Int(i.yemek_siparis_adet!)!, kullanici_adi: i.kullanici_adi!)
                    return
                }
            }
            print("add")
            viewModel.addToCart(yemek_adi: food.yemek_adi!, yemek_resim_adi: food.yemek_resim_adi!, yemek_fiyat: foodPrice, yemek_siparis_adet: foodCount, kullanici_adi: "s_omer_sari")
        }
     
       
    }
    
    

    @IBAction func getBasket(_ sender: Any) {
         performSegue(withIdentifier: "toChart", sender: nil)
    }
    

}
