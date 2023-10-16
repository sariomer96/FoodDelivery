//
//  AddToCart.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit
import SDWebImage
class MyBasket: UIViewController {

    @IBOutlet weak var deleteAllElement: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var basketList = [BasketFoods]()
    var viewModel = MyBasketViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        self.getBasket()

        _ = viewModel.basketList.subscribe(onNext: {  list in
            self.basketList = list
      
  
            DispatchQueue.main.async {
                
           
              
             self.tableView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteAllElementClicked(_ sender: Any) {
        
        DispatchQueue.main.async {
            
            for i in self.basketList {
            
                self.viewModel.deleteFoodOnBasket(sepet_yemek_id: Int(i.sepet_yemek_id!)!, kullanici_adi: i.kullanici_adi!)
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    

    @IBAction func deleteBasket(_ sender: Any) {
        viewModel.deleteFoodOnBasket(sepet_yemek_id: 103055, kullanici_adi: "s_omer_sari")
        
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
             
         
         
        
        return cell
    }
    
    @objc func deleteCell(id : UIButton){
        
        DispatchQueue.main.async {
            self.viewModel.deleteFoodOnBasket(sepet_yemek_id: id.tag, kullanici_adi: "s_omer_sari")
            self.tableView.reloadData()
        }
       
    }
    func getBasket() {
        viewModel.fRepo.getCartFood(kullanici_adi: "s_omer_sari")
    }
    
    
}
