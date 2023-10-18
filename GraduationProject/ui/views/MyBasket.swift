//
//  AddToCart.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit
import SDWebImage
class MyBasket: UIViewController {

 
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var basketList = [BasketFoods]()
    var viewModel = MyBasketViewModel()
    let userName = "s_omer_sari"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
       

      
        
     
        // Do any additional setup after loading the view.
    }
    
   
    func getTotalPrice(basketList:[BasketFoods]) -> Int {
        
        for i in basketList {
            
            viewModel.totalPrice += Int(i.yemek_fiyat!)!
        }
        
        return viewModel.totalPrice
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
             self.getBasket()
        
         
        
         _ = viewModel.basketList.subscribe(onNext: {  list in
             self.basketList = list
       
   
             DispatchQueue.main.async {
                 
                 let total = self.getTotalPrice(basketList: self.basketList)
                 
                   
                   self.totalPriceLabel.text = String(total)
                 self.totalPriceLabel.text! += Constants.shared.tl
               
              self.tableView.reloadData()
             }
         })
        self.tableView.reloadData()
    }

    
    @IBAction func acceptBasket(_ sender: Any) {
        DispatchQueue.main.async {
            
            for i in self.basketList {
            
                self.viewModel.deleteFoodOnBasket(sepet_yemek_id: Int(i.sepet_yemek_id!)!, kullanici_adi: i.kullanici_adi!) { result in }
                
            }
            
            self.tableView.reloadData()
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
        
  
        self.viewModel.deleteFoodOnBasket(sepet_yemek_id: id.tag, kullanici_adi: self.userName) { res in }
            self.tableView.reloadData()
         
       
    }
    func getBasket() {
        viewModel.fRepo.getCartFood(kullanici_adi: userName) { result in
            
        }
    }
    
    
}
