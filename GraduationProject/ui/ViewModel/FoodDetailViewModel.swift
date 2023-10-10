//
//  FoodDetailViewModel.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import Foundation
import RxSwift

class FoodDetailViewModel {
    
    
    var fRepo = FoodDaoRepository()
    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    
    init(){
        foodList = fRepo.foodList
    }
    
    func addToCart(yemek_adi: String,yemek_resim_adi:String,yemek_fiyat : Int
    , yemek_siparis_adet : Int ,  kullanici_adi : String)
    {
        fRepo.addToCartFood(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    func getCart(){
        fRepo.getCartFood()
    }
}
