//
//  HomePageViewModel.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import Foundation
import RxSwift

final class HomePageViewModel {
    
    var fRepo = FoodDaoRepository()
    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    
    init() {
        foodList = fRepo.foodList
    }

    func getFoods() {
        fRepo.getFoods()
    }
    
     
}
