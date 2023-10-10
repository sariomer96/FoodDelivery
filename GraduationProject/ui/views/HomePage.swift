//
//  ViewController.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import UIKit

class HomePage: UIViewController {

    var foodList = [Foods]()
    
    var viewModel = HomePageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = viewModel.foodList.subscribe(onNext: {  list in
            self.foodList = list
      
            DispatchQueue.main.async {
   
                for i in self.foodList {
                    print(i.yemek_adi)
                }
              
              //  self.kisilerTableView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getFoods()
    }


}

