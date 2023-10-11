//
//  AddToCartViewModel.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import Foundation
import RxSwift
class MyBasketViewModel {
    
    var fRepo = FoodDaoRepository()
    var basketList = BehaviorSubject<[BasketFoods]>(value: [BasketFoods]())
    
    init(){
        basketList = fRepo.basketList
    }
    
    func deleteFoodOnBasket(sepet_yemek_id:Int,kullanici_adi:String){
        fRepo.deleteFoodOnBasket(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
   
    
}
