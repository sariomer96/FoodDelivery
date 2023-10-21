//
//  AddToCart.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit
import SDWebImage
class MyBasket: UIViewController {

    @IBOutlet weak var tableViewCart: UITableView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
 
    var basketList = [BasketFoods]()
    var viewModel = MyBasketViewModel()
   
   
 
   
    func getTotalPrice(basketList:[BasketFoods]) -> Int {
        
        viewModel.totalPrice = 0
        for i in basketList {
            
            viewModel.totalPrice += Int(i.yemek_fiyat!)!
        }
        
        return viewModel.totalPrice
    }
    
    override func viewDidLoad() {
        
       
        tableViewCart.dataSource = self
        tableViewCart.delegate = self
            super.viewDidLoad()
  
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getBasket()
    
   
  _ = viewModel.basketList.subscribe(onNext: {  list in
      self.basketList = list

         
      DispatchQueue.main.async {
    
          let total = self.getTotalPrice(basketList: self.basketList)
          
            
            self.totalPriceLabel.text = String(total)
          self.totalPriceLabel.text! += ConstantCurrencies.TurkishCurrency
        
       self.tableViewCart.reloadData()
         
      }
  })
      
    }
    
    @IBAction func acceptBasket(_ sender: Any) {
        DispatchQueue.main.async {
            
            for (index, i) in self.basketList.enumerated() {
                print("\(index)  \(self.basketList.endIndex - 1)")
                
                
                if index == (self.basketList.endIndex - 1) {
                  
                    self.viewModel.fRepo.deleteFoodOnBasket(sepet_yemek_id: Int(i.sepet_yemek_id!)!, kullanici_adi: i.kullanici_adi!) { result in
                    
                        self.getBasket()
                    }
                }else{
                  
                    self.viewModel.fRepo.deleteFoodOnBasket(sepet_yemek_id: Int(i.sepet_yemek_id!)!, kullanici_adi: i.kullanici_adi!) { result in
                        
                    }
                }
                
                
            }
            self.totalPriceLabel.text = "0 \(Constants.shared.tl)"
             
        }
    
    }
    
}

extension MyBasket : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basketList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! CartTableViewCell
        
        let basket = self.basketList[indexPath.row]
    
        
        let id = Int(basket.sepet_yemek_id!)!
        
       
    
        cell.deleteClick.tag = id
        
        cell.deleteClick.addTarget(self, action: #selector(deleteCell(id: )), for: .touchUpInside)
        
             cell.countLabel.text = basket.yemek_siparis_adet
             cell.totalPriceLabel.text = basket.yemek_fiyat
             
             
        cell.foodImageView.sd_setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(basket.yemek_resim_adi!)"), placeholderImage: UIImage(named: basket.yemek_resim_adi!))
             
        cell.foodNameLabel.text = basket.yemek_adi!
         
        
        return cell
    }
    
    @objc func deleteCell(id : UIButton){
        
  
       
        self.viewModel.fRepo.deleteFoodOnBasket(sepet_yemek_id: id.tag, kullanici_adi: Constants.shared.userName) { res in
                 
                self.getBasket()
            }
        }
        
        
           
    func getBasket() {
        viewModel.fRepo.getCartFood(kullanici_adi: Constants.shared.userName) { result in
              
        }
   
    }
       
}
  
    
    
