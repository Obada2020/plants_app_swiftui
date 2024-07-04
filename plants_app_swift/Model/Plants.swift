//
//  Plants.swift
//  plants_app_swift
//
//  Created by Obada Alhalabi on 27/06/2024.
//

import Foundation

struct Plant : Identifiable, Equatable{
    var id: String = UUID().uuidString
    var imageName: String
    var plantName: String
    var price: String
}
    
var plants: [Plant] = [
    Plant(imageName: "plant1", plantName: "Plant 1", price: "10 $"),
    Plant(imageName: "plant2", plantName: "Plant 2", price: "20 $"),
    Plant(imageName: "plant3", plantName: "Plant 3", price: "30 $"),
    Plant(imageName: "plant4", plantName: "Plant 4", price: "40 $")
]
