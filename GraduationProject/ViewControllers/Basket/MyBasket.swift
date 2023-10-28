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
   
    override func viewDidLoad() {
        
       
        tableViewCart.dataSource = self
        tableViewCart.delegate = self
            super.viewDidLoad()
  
    }
    
    func getTotalPrice(basketList:[BasketFoods]) -> Int {
        
        viewModel.totalPrice = 0
        for i in basketList {
            
            viewModel.totalPrice += Int(i.yemek_fiyat!)!
        }
        
        return viewModel.totalPrice
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
            
            for (ind, i) in self.basketList.enumerated() {
                print("\(ind)  \(self.basketList.endIndex - 1)")
                
                
                if ind == (self.basketList.endIndex - 1) {
                  
                    self.viewModel.fRepo.deleteFoodOnBasket(index:ind,basketList: self.basketList ,sepet_yemek_id: Int(i.sepet_yemek_id!)!, kullanici_adi: i.kullanici_adi!) { result in
                    
                        self.getBasket()
                    }
                }else{
                  
                    self.viewModel.fRepo.deleteFoodOnBasket(index:ind,basketList: self.basketList ,sepet_yemek_id: Int(i.sepet_yemek_id!)!, kullanici_adi: i.kullanici_adi!) { result in
                        
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ contextualAction,view,bool in
            let basketElement = self.basketList[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(basketElement.yemek_adi!) Silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.fRepo.deleteFoodOnBasket(index: indexPath.row,basketList: self.basketList,sepet_yemek_id: Int(basketElement.sepet_yemek_id!)!, kullanici_adi: Constants.shared.userName) { result in
                    
//                   
//                    tableView.reloadData()
                }
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! CartTableViewCell
        
        let basket = self.basketList[indexPath.row]
    
        
        let id = Int(basket.sepet_yemek_id!)!
        
      
      //  cell.contentView.layer.borderColor = UIColor.green.cgColor
        
        // Configure the cell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.darkGray.cgColor
       
        
             let price = Int( basket.yemek_fiyat!)
             let amount = Int(basket.yemek_siparis_adet!)
        
             let priceAmount = price! / amount!
            
             cell.priceLabel.text = "\(Constants.shared.tl) \(priceAmount)"
             cell.countLabel.text = basket.yemek_siparis_adet
             cell.totalPriceLabel.text = "\(Constants.shared.tl) \(basket.yemek_fiyat!)"
          
             
        cell.foodImageView.sd_setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(basket.yemek_resim_adi!)"), placeholderImage: UIImage(named: basket.yemek_resim_adi!))
             
        cell.foodNameLabel.text = basket.yemek_adi!
         
        
        return cell
    }
   
    
   
        
        
           
    func getBasket() {
        viewModel.fRepo.getCartFood(kullanici_adi: Constants.shared.userName) { result in
        }
   
    }
       
}
  
    
    

