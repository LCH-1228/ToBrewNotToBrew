//
//  ViewController.swift
//  ToBrewNotToBrew
//
//  Created by Chanho Lee on 4/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    let menus: [Menu] = [
            Menu(name: "Americano", price: 4300, image: "americano", category: .toBrew),
            Menu(name: "Cappuccino", price: 4500, image: "cappuccino", category: .toBrew),
            Menu(name: "Cream Latte", price: 4600, image: "creamLatte", category: .toBrew),
            Menu(name: "Frappe", price: 4600, image: "frappe", category: .toBrew),
            Menu(name: "Irish Coffee", price: 4800, image: "irishCoffee", category: .toBrew),
            Menu(name: "Latte", price: 4600, image: "latte", category: .toBrew),
            Menu(name: "Macchiato", price: 4800, image: "macchiato", category: .toBrew),
            
            Menu(name: "Cherry Coke", price: 4000, image: "cherryCoke", category: .notToBrew),
            Menu(name: "Coke", price: 4000, image: "coke", category: .notToBrew),
            Menu(name: "Grapefruit Juice ", price: 4800, image: "grapefruitJuice", category: .notToBrew),
            Menu(name: "Green Juice", price: 4800, image: "greenJuice", category: .notToBrew),
            Menu(name: "Ice Tea", price: 4300, image: "iceTea", category: .notToBrew),
            Menu(name: "Lime Juice", price: 4300, image: "limeJuice", category: .notToBrew),
            Menu(name: "Mojito", price: 5000, image: "mojito", category: .notToBrew),
            Menu(name: "Orange Juice", price: 4800, image: "orangeJuice", category: .notToBrew)
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

