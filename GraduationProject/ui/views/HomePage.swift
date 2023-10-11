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
    var viewModel = HomePageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        _ = viewModel.foodList.subscribe(onNext: {  list in
            self.foodList = list
      
            DispatchQueue.main.async {
   
             
                for i in self.foodList {
                    self.imageList.append(i.yemek_resim_adi!)
                }
                
               
              self.foodCollectionView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getFoods()
    }
 

}

extension HomePage : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(imageList.count)
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        print(cell.imageView)

        cell.imageView.sd_setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(imageList[indexPath.row])"), placeholderImage: UIImage(named: imageList[indexPath.row]))
        return cell
        
    }
    
    
}

