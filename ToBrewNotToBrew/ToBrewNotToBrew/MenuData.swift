//
//  MenuData.swift
//  ToBrewNotToBrew
//
//  Created by Chanho Lee on 4/9/25.
//

struct Menu {
    let name: String
    let price: Int
    let image: String
    let category: category
    
    enum category {
        case toBrew
        case notToBrew
    }
}
