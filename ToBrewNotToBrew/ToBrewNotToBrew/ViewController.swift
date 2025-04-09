//
//  ViewController.swift
//  ToBrewNotToBrew
//
//  Created by Chanho Lee on 4/7/25.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func setData(menuData: [Menu])
}

class ViewController: UIViewController, MenuCollectionViewDelegate {
    
    let myView = MenuCollectionView()
        
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
    
    var currentMenu: [Menu] = []
    
    var isToBrew = true
    
    //메뉴 변경 기능을 구현을 위한 테스트 버튼
    let categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("카테고리 변경", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(categoryButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("뷰컨 로딩 완료")
        
        //주입할 데이터 필터링
        currentMenu = menus.filter({$0.category == .toBrew})
        
        //데이터 주입
        myView.setData(menuData: currentMenu)
        
        //collectionView에서 클릭된 cell 확인을 위한 delegate 지정
        myView.delegate = self
        
        view.backgroundColor = .white //디버깅을 위한 배경색상 지정
        view.addSubview(myView) //디버깅을 위한 addSubview
        
        //원하는 곳에 배치 후 constraint 조건 수정 필요
        myView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        //테스트 버튼 추가
        view.addSubview(categoryButton)
        
        // 메뉴 업데이트 기능 구현을 위한 버튼
        categoryButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(30)
            make.bottom.equalToSuperview()
        }
    }
    
    //어떤 cell이 클릭되었는지 출력 장바구니 UITable뷰와 연동 필요
    func cellTapped(_ index: IndexPath) {
        print(index[1])
    }
    
    //아래 버튼 동작 카테고리 메뉴 UISegmentedControl과 연동 필요
    @objc func categoryButtonClicked() {
        if isToBrew == true {
            currentMenu = menus.filter({$0.category == .notToBrew})
            isToBrew = false
        } else if isToBrew == false {
            currentMenu = menus.filter({$0.category == .toBrew})
            isToBrew = true
        }
        myView.setData(menuData: currentMenu)
    }
}
