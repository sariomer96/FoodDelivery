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
//    var kisilerListesi = BehaviorSubject<[Foods]>(value: [Foods]())
//    //http://kasimadalan.pe.hu/kisiler/tum_kisiler.php
//    
//    func kaydet(kisi_ad:String,kisi_tel:String){
//        let params:Parameters = ["kisi_ad":kisi_ad,"kisi_tel":kisi_tel]
//        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php",method: .post,parameters: params).response {
//            response in
//            
//            if let data = response.data {
//                do{
//                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
//                    print(cevap.success)
//                    print(cevap.message)
//                }catch{
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//
//    func guncelle(kisi_id:Int,kisi_ad:String,kisi_tel:String){
//        let params:Parameters = ["kisi_ad":kisi_ad,"kisi_tel":kisi_tel]
//        AF.request("http://kasimadalan.pe.hu/kisiler/update_kisiler.php",method: .post,parameters: params).response {
//            response in
//
//            if let data = response.data {
//                do{
//                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
//                    print(cevap.success)
//                    print(cevap.message)
//                }catch{
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
    
//    func ara(aramaKelimesi:String){
//        let params:Parameters = ["kisi_ad":aramaKelimesi]
//        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php",method: .post,parameters: params).response { response in
//            if let data = response.data{
//                do{
//                    let cevap = try JSONDecoder().decode(KisilerCevap.self, from: data)
//                    if let liste = cevap.kisiler {
//                        self.kisilerListesi.onNext(liste)
//                    }
//                }catch{
//                    print(error.localizedDescription)
//                }
//            }
//        }
//
//    }
//
//    func sil(kisi_id:Int){
//        let params:Parameters = ["kisi_id":kisi_id]
//        AF.request("http://kasimadalan.pe.hu/kisiler/delete.php",method: .post,parameters: params).response {
//            response in
//
//            if let data = response.data {
//                do{
//                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
//                    print("----DELETE---")
//                    print(cevap.success)
//                    print(cevap.message)
//                }catch{
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
    
//    func kisileriYukle(){
//        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php",method: .get).response { response in
//            if let data = response.data{
//                do{
//                    let cevap = try JSONDecoder().decode(KisilerCevap.self, from: data)
//                    if let liste = cevap.kisiler {
//                        self.kisilerListesi.onNext(liste)
//                    }
//                }catch{
//                    print(error.localizedDescription)
//                }
//            }
//
//        }
//    }
    
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
    func getCartFood(kullanici_adi:String) {
        
        let params:Parameters = ["kullanici_adi":kullanici_adi]
                AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).response {
                    response in
                     
                    if let data = response.data {
                        do{
                            var cevap = try JSONDecoder().decode(BasketResponse.self, from: data)
                               //success
                            if let list = cevap.sepet_yemekler {
                                self.basketList.onNext(list)
                                
                            }
 
                        }catch{
                             print(error.localizedDescription)
                            print("error")
                        }
                    }
                }
    }
    
    func deleteFoodOnBasket(sepet_yemek_id : Int,kullanici_adi:String){
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]
                AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).response {
                    response in
                     
                    if let data = response.data {
                        do{
                            var cevap = try JSONDecoder().decode(CRUDResponse.self, from: data)
                               //success
                      
                        }catch{
                             print(error.localizedDescription)
                            print("error")
                        }
                    }
                }
    }
    func getFoodImages(){
        
    }
    
}
