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
    var totalPrice = 0
    
    init(){
        basketList = fRepo.basketList
    }
    
 
    
   
    
}
