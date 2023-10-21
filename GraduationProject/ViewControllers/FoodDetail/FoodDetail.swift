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
        
        
        viewModel.getCart(kullanici_adi: Constants.shared.userName) { result  in
        
        }
        
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
     
    func addChart(completion: @escaping (Result<Int, Constants.Errors>) -> Void){
        if let food = self.food {
            
           
            var esit = false
            for (index, i) in self.basketList.enumerated() {
             
                if i.yemek_adi == food.yemek_adi {

                    
                       esit = true
                    self.viewModel.fRepo.deleteFoodOnBasket(sepet_yemek_id: Int(i.sepet_yemek_id!)! , kullanici_adi: Constants.shared.userName){ result in
                        self.viewModel.addToCart(yemek_adi: food.yemek_adi!, yemek_resim_adi: food.yemek_resim_adi!, yemek_fiyat: self.foodPrice + Int(i.yemek_fiyat!)!, yemek_siparis_adet: Int(i.yemek_siparis_adet!)! + self.foodCount, kullanici_adi: Constants.shared.userName)
                        
                        completion(.success(1))
                              
                    }
              
                }
              }
 
            if esit == false {
                
                self.viewModel.addToCart(yemek_adi: food.yemek_adi!, yemek_resim_adi: food.yemek_resim_adi!, yemek_fiyat: self.foodPrice, yemek_siparis_adet: self.foodCount, kullanici_adi: Constants.shared.userName)
            }
        }
    }
    @IBAction func addToCart(_ sender: Any) {
 
        
        viewModel.fRepo.getCartFood(kullanici_adi: "s_omer_sari") { result  in
           
            self.addChart() { res in
                
            }

        }
    }
     
}
