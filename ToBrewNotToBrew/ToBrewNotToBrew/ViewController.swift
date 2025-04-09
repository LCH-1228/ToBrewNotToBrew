//
//  ViewController.swift
//  ToBrewNotToBrew
//
//  Created by Chanho Lee on 4/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    let orderTableView = TableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(orderTableView)
        
        orderTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }


}

