//
//  ViewController.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit
import SDWebImage

final class HomePage: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet  private weak var foodCollectionView: UICollectionView!
    private var foodList = [Foods]()
    private var imageList = [String]()
    private var foodNameList = [String]()
    private var foodPriceList = [String]()
    private var viewModel = HomePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        configureCallBacks()
        viewModel.getFoods()
        refreshList()
        
        edgesForExtendedLayout = UIRectEdge.bottom
    }

    private func initViews() {
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
    }

    private func configureCallBacks() {

        _ = viewModel.foodList.subscribe(onNext: { list in
            self.foodList = list
            for food in self.foodList {
                guard let image = food.yemek_resim_adi,
                      let name = food.yemek_adi,
                      let price = food.yemek_fiyat else { return }

                self.imageList.append(image)
                self.foodNameList.append(name)
                self.foodPriceList.append(price)
                self.foodCollectionView.reloadData()
            }
        })

    }

    private func refreshList(){
        foodList.removeAll()
        imageList.removeAll()
        foodNameList.removeAll()
        foodPriceList.removeAll()
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

extension HomePage : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
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
        cell.labelFiyat.text = "\(Constants.shared.tl) \(foodPriceList[indexPath.row])"
        
        cell.imageView.sd_setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(imageList[indexPath.row])"), placeholderImage: UIImage(named: imageList[indexPath.row]))
        return cell
        
    }

  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        // 32 constraints + inter space
        let width: CGFloat = (screenWidth - 16)/2
        let height: CGFloat = 298
        return .init(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }
}
