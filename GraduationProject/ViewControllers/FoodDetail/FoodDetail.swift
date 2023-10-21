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
    
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var food : Foods?
    var viewModel = FoodDetailViewModel()
    var foodCount = 1
    var foodTotalPrice = 0
    var price = 0
    var basketList = [BasketFoods]()
    
    @IBAction func stepperClicked(_ sender: UIStepper) {
        foodCountLabel.text = String(Int(sender.value))
        foodCount = Int(sender.value)
    
   
        let totalPrice = Int(sender.value) * Int((food?.yemek_fiyat)!)!
        foodTotalPrice = totalPrice
        foodTotalPriceLabel.text = "\(Constants.shared.tl) \(totalPrice)"
        
    }
    @IBOutlet weak var foodTotalPriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.getCart(kullanici_adi: Constants.shared.userName) { result  in
           
        }
        
        _ = viewModel.basketList.subscribe(onNext: {  list in
            self.basketList = list
 
        })
        if let f = food {
          
            self.price = Int((self.food?.yemek_fiyat)!)!
            foodTotalPrice = Int(f.yemek_fiyat!)!
            setFoodImage(food: f)
            setFoodProperties(f: f)
            
        }
    }
    func setFoodImage(food:Foods){

        imageView.sd_setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)"), placeholderImage: UIImage(named: food.yemek_resim_adi!))
    
    }
    func setFoodProperties (f:Foods) {
        let yemekName = f.yemek_adi
        let totalPrice = f.yemek_fiyat
      
        foodPriceLabel.text = "\(Constants.shared.tl) \(price)"
        foodTotalPriceLabel.text = "\(Constants.shared.tl) \(totalPrice!)"
        foodName.text = yemekName

    }
     
    func addChart(completion: @escaping (Result<Int, Constants.Errors>) -> Void){
        if let food = self.food {
            
           
            var cont = false
            for (index, i) in self.basketList.enumerated() {
             
                if i.yemek_adi == food.yemek_adi {

                    
                    cont = true
                    self.viewModel.fRepo.deleteFoodOnBasket(sepet_yemek_id: Int(i.sepet_yemek_id!)! , kullanici_adi: Constants.shared.userName){ result in
                        self.viewModel.addToCart(yemek_adi: food.yemek_adi!, yemek_resim_adi: food.yemek_resim_adi!, yemek_fiyat: self.foodTotalPrice + Int(i.yemek_fiyat!)!, yemek_siparis_adet: Int(i.yemek_siparis_adet!)! + self.foodCount, kullanici_adi: Constants.shared.userName)
                        
                        completion(.success(1))
                              
                    }
              
                }
              }
 
            if cont == false {
                
                self.viewModel.addToCart(yemek_adi: food.yemek_adi!, yemek_resim_adi: food.yemek_resim_adi!, yemek_fiyat: self.foodTotalPrice, yemek_siparis_adet: self.foodCount, kullanici_adi: Constants.shared.userName)
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
