//
//  FoodDaoRepository.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import Foundation
import RxSwift
import Alamofire

class FoodDaoRepository {


    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    var basketList = BehaviorSubject<[BasketFoods]>(value: [BasketFoods]())
    
    func getFoods () {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(FoodResponse.self, from: data)
                    if let liste = cevap.yemekler {
                        
                       
                       self.foodList.onNext(liste)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
    }
   
    func search(word : String) {
        
        let lowerWord = word.lowercased()
        
        
              var searchedList = [Foods]()
        searchedList.removeAll()
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(FoodResponse.self, from: data)
                    if let liste = cevap.yemekler {
                        
                        for i in liste {
                            let a = i.yemek_adi!
                            
                            let lowerFood = a.lowercased()
                            if (lowerFood.contains(lowerWord)){
                                searchedList.append(i)
                            }
                        }
                        
                        if searchedList.isEmpty {
                            self.foodList.onNext(liste)
                            print("searchempty")
                        }else{
                             
                            for i in searchedList {
                                print(i.yemek_adi!)
                            }
                            self.foodList.onNext(searchedList)
                        }
                      
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }

//
//
//        self.foodList.onNext(list)
       // return list
            
            
    }
    func addToCartFood(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,
                   kullanici_adi:String){
        
        let params:Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi]
                AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).response {
                    response in
        
                    if let data = response.data {
                        do{
                            let cevap = try JSONDecoder().decode(CRUDResponse.self, from: data)
                              
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }
    }
    func getCartFood(kullanici_adi:String,completion: @escaping (Result<Int, Constants.Errors>) -> Void) {
       
        let params:Parameters = ["kullanici_adi":kullanici_adi]
                AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).response {
                    response in
                    if let data = response.data {
                        do{
                           
                            var cevap = try JSONDecoder().decode(BasketResponse.self, from: data)
                               //success
                            if let list = cevap.sepet_yemekler {
                                self.basketList.onNext(list)
                              
                                completion(.success(1))
                            }
                        }catch{
                            var emptyList = [BasketFoods]()
                           
                            self.basketList.onNext(emptyList)
                            completion(.success(1))
                           
                        }
                    }
                }
    }
    
    func deleteFoodOnBasket(sepet_yemek_id : Int,kullanici_adi:String,completion: @escaping (Result<Int, Constants.Errors>) -> Void){
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]
                AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).response {
                    response in
                     
                    if let data = response.data {
                        do{
                            var cevap = try JSONDecoder().decode(CRUDResponse.self, from: data)
                               //success
                            
                            if let resp = cevap.success {
                          
                                completion(.success(1))
                            }
                           
                        }catch{
                        }
                    }
                }
    }
    
 
    
}
