//
//  ViewController.swift
//  ToBrewNotToBrew
//
//  Created by Chanho Lee on 4/7/25.
//

import UIKit

class ViewController: UIViewController, MenuSelectionDelegate {
    // 비어있는 아이템 배열 생성
    var orderItem: [OrderItem] = []
    
    // 메뉴가 선택될 때 실행되는 메서드
    func didSelectMenuItem(_ item: OrderItem) {
//        orderItem.append(item)
        orderTableView.updateOrders(orderItem)
        
    }
    
    // 테이블 뷰 생성
    let orderTableView = TableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // 더미 데이터
        let testItem = OrderItem(name: "Latte", price: 3000, imageName: "latte", quantity: 1)
        let testItem2 = OrderItem(name: "Latte", price: 3000, imageName: "latte", quantity: 1)
        
        // 더미 데이터를 받아와서 updateOrders 메서드 실행
        orderTableView.updateOrders([testItem, testItem2])
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

