//
//  model.swift
//  ToBrewNotToBrew
//
//  Created by 김기태 on 4/7/25.
//
import UIKit
import SnapKit

struct Drink {
    let name: String
    let price: Int
    let imageName: String
}

struct EmptyCart {
    let image: String
    let status: String
}

struct Menu {
    var menuArr: [Drink] = []
    
    mutating func makeMenu(_name: String, _price: Int, _imageName: String) {
        let newDrink = Drink(name: _name, price: _price, imageName: _imageName)
        menuArr.append(newDrink)
    }
    
    mutating func deleteMenu(name: String) {
        if let index = menuArr.firstIndex(where: { $0.name == name }) {
            menuArr.remove(at: index)
        }
    }
}



//    // to brew(coffee)
//    let americano = Drink(name: "Americano", price: 4700, imageName: )
//    let cafeLatte = Drink(name: "CafeLatte", price: 5200)
//    let flatwhite = Drink(name: "FlatWhite", price: 5800)
//    let espresso = Drink(name: "Espresso", price: 3900)
//    
//    // not to brew(non coffee)
//    let peachBlackTea = Drink(name: "PeachBlackTea", price: 6100)
//    let yujaMintTea = Drink(name: "YujaMintTea", price: 6100)
//    let earlGrey = Drink(name: "EarlGrey", price: 4500)
//    let grapeFruit = Drink(name: "GrapeFruit", price: 6300)
    
    

