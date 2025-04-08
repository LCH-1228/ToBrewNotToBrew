//
//  ViewController.swift
//  ToBrewNotToBrew
//
//  Created by Chanho Lee on 4/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    private let homeView = HomeView()
    
    //loadView()를 override해서 원하는 view를 지정
    override func loadView() {
        self.view = homeView
    }
}

