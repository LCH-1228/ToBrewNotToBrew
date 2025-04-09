//
//  Protocol.swift
//  ToBrewNotToBrew
//
//  Created by 김기태 on 4/9/25.
//

protocol MenuSelectionDelegate: AnyObject {
    func didSelectMenuItem(_ item: OrderItem)
}
