//
//  Foods.swift
//  GraduationProject
//
//  Created by Omer on 10.10.2023.
//

import Foundation

class Foods : Codable {
    var yemekID:String?
    var yemekAdi:String?
    var yemekResimAdi:String?
    var yemekFiyat:String?
    
    init(yemekID: String, yemekAdi: String, yemekResimAdi: String, yemekFiyat: String) {
        self.yemekID = yemekID
        self.yemekAdi = yemekAdi
        self.yemekResimAdi = yemekResimAdi
        self.yemekFiyat = yemekFiyat
    }
}




 
