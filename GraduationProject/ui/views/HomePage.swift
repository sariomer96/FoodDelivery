//
//  ViewController.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit
import SDWebImage

class HomePage: UIViewController {

    @IBOutlet weak var foodCollectionView: UICollectionView!
    var foodList = [Foods]()
    var imageList = [String]()
    var foodNameList = [String]()
    var foodPriceList = [String]()
    var viewModel = HomePageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        self.viewModel.getFoods()
        self.refreshList()
        _ = viewModel.foodList.subscribe(onNext: {  list in
           
         
            self.foodList = list
      
          
            DispatchQueue.main.async {
   
             
                for i in self.foodList {
                    self.imageList.append(i.yemek_resim_adi!)
                    self.foodNameList.append(i.yemek_adi!)
                    self.foodPriceList.append(i.yemek_fiyat!)
                }
                
               
              self.foodCollectionView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    func refreshList(){
        
        self.foodList.removeAll()
        self.imageList.removeAll()
        self.foodNameList.removeAll()
        self.foodPriceList.removeAll()
        
        
    }
 
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let food = sender as? Foods {
                let targetVC = segue.destination as! FoodDetail
                targetVC.food = food
            }
        }
    }
}

extension HomePage : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(imageList.count)
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: food)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
     
        cell.labelUrunAdi.text = foodNameList[indexPath.row]
        cell.labelFiyat.text = foodPriceList[indexPath.row]
        
        cell.imageView.sd_setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(imageList[indexPath.row])"), placeholderImage: UIImage(named: imageList[indexPath.row]))
        return cell
        
    }
    
    
}

