//
//  AddToCart.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit

class MyBasket: UIViewController {

    var basketList = [BasketFoods]()
    var viewModel = MyBasketViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = viewModel.basketList.subscribe(onNext: {  list in
            self.basketList = list
      
            DispatchQueue.main.async {
   
             
              
              //  self.kisilerTableView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    

    @IBAction func deleteBasket(_ sender: Any) {
        viewModel.deleteFoodOnBasket(sepet_yemek_id: 103055, kullanici_adi: "s_omer_sari")
        viewModel.deleteFoodOnBasket(sepet_yemek_id: 103076, kullanici_adi: "s_omer_sari")
        viewModel.deleteFoodOnBasket(sepet_yemek_id: 103077, kullanici_adi: "s_omer_sari")
        viewModel.deleteFoodOnBasket(sepet_yemek_id: 103081, kullanici_adi: "s_omer_sari")
        viewModel.deleteFoodOnBasket(sepet_yemek_id: 103082, kullanici_adi: "s_omer_sari")
    }
    
}
