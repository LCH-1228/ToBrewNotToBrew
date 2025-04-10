//
//  orderDetails.swift
//  ToBrewNotToBrew
//
//  Created by 김기태 on 4/8/25.
//

import UIKit
import SnapKit


class TableView: UIView {
    
    let shoppingCart = UILabel() // 장바구니 레이블
    let trashCan = UIImageView()
    
    private func shoppingCartUI() {
        addSubview(shoppingCart)
        // 장바구니 UI 설정
        shoppingCart.text = "장바구니"
        shoppingCart.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        
        shoppingCart.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview()
        }
    }
    private func trashCanUI() {
        addSubview(trashCan)
        trashCan.image = UIImage(named: "Trash")
        trashCan.snp.makeConstraints {
            $0.leading.equalTo(shoppingCart.snp.trailing).offset(30)
        }
    }

    let tableView = UITableView()
    // didSet을 통해서 값을 갱신해줌.
    var orderItems: [OrderItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    // orderItem 프로퍼티에 [OrderItem] 집어 넣는 메서드
    func updateOrders(_ item: [OrderItem]) {
        self.orderItems = item
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shoppingCartUI()
        setupTableView()
        trashCanUI()
        tableView.isScrollEnabled = false
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shoppingCartUI()
        setupTableView()
        trashCanUI()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // 셀 등록
        tableView.register(OrderItemCell.self, forCellReuseIdentifier: "OrderItemCell")
        // 테이블 뷰제약 조건
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(shoppingCart.snp.bottom).offset(20)
        }
        
    }
}
extension TableView: UITableViewDelegate, UITableViewDataSource {
    // 테이블 뷰 행 개수. 1. 장바구니에 아무것도 없을 때, 2. 장바구니에 담겨있을 때로 구성해야함.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if orderItems.count == 0 {
            return 1 // 1. 장바구니에 아무것도 없을 때, 1개 만듦.
        } else {
            return orderItems.count // 2. 담긴 개수 만큼 만듦.
        }
    }
    // 테이블 뷰 내용.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as? OrderItemCell else {
            return UITableViewCell()
        }
        if orderItems.count == 0 { // 장바구니에 아무것도 없을 때
            cell.basicConfigure()
            return cell
            
        } else {
            let item = orderItems[indexPath.row]
            cell.purchaseConfigure(with: item)
            return cell
        }
        
    }
    
    
    
    
    // 테이블 뷰 셀
    class OrderItemCell: UITableViewCell {
        var orderItems: [OrderItem] = []
        let statusLabel = UILabel() // 기본 상태 레이블
        let cartImageView = UIImageView() // 기본 상태 이미지(카트)
        let coffeeImageView = UIImageView() // 커피 이미지
        let nameLabel = UILabel() // 커피 이름
        let priceLabel = UILabel() // 가격
        let minueButton = UIButton() // 마이너스 버튼
        let plusButton = UIButton() // 플러스 버튼
        let quantityLabel = UILabel() // 수량
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            basicSetupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            basicSetupUI()
            
        }
        
        private func basicSetupUI() {
            [statusLabel, cartImageView, coffeeImageView, nameLabel, priceLabel, minueButton, plusButton, quantityLabel].forEach {
                contentView.addSubview($0)
                $0.isHidden = true // 처음엔 안보이게
            }
            
            
            // 카트 이미지 UI 설정
            cartImageView.contentMode = .scaleAspectFit
            cartImageView.clipsToBounds = true
            
            cartImageView.snp.makeConstraints {
                $0.width.equalTo(50)
                $0.top.equalToSuperview().offset(30)
                $0.bottom.equalToSuperview().offset(30)
                $0.centerX.equalToSuperview()
            }
            
            // 기본상태(주문내역x) 레이블 UI 설정
            statusLabel.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(cartImageView.snp.bottom).offset(10)
            }
            
            // 커피 이미지 UI 설정
            coffeeImageView.contentMode = .scaleAspectFit
            coffeeImageView.clipsToBounds = true
            coffeeImageView.backgroundColor = .white
            
            coffeeImageView.snp.makeConstraints {
                $0.width.height.equalTo(64)
                $0.top.equalToSuperview().offset(55)
                
                $0.leading.equalToSuperview().offset(20)
                $0.centerY.equalToSuperview()
            }
            
            // 커피 이름 레이블 UI 설정
            nameLabel.text = "Latte"
            nameLabel.font = UIFont(name: "NotoSansKR-Regular", size: 16)
            
            nameLabel.snp.makeConstraints {
                $0.leading.equalTo(coffeeImageView.snp.trailing).offset(12)
                $0.top.equalTo(coffeeImageView.snp.top)
            }
            
            // 커피 가격 레이블 UI 설정
            priceLabel.text = "4,000원"
            priceLabel.font = UIFont(name: "NotoSansKR-Bold", size: 18)
            
            priceLabel.snp.makeConstraints {
                $0.leading.equalTo(coffeeImageView.snp.trailing).offset(12)
                $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            }
            
            // 마이너스 버튼 UI 설정
            minueButton.setTitle("-", for: .normal)
            minueButton.setTitleColor(.white, for: .normal)
            minueButton.backgroundColor = .brown
            minueButton.layer.cornerRadius = 15
            
            minueButton.snp.makeConstraints {
                $0.size.equalTo(30)
                $0.centerY.equalTo(coffeeImageView.snp.centerY)
                $0.trailing.equalToSuperview().offset(-100)
            }
            
            // 플러스 버튼 UI 설정
            plusButton.setTitle("+", for: .normal)
            plusButton.setTitleColor(.white, for: .normal)
            plusButton.backgroundColor = .brown
            plusButton.layer.cornerRadius = 15
            
            plusButton.snp.makeConstraints {
                $0.size.equalTo(30)
                $0.centerY.equalTo(coffeeImageView.snp.centerY)
                $0.leading.equalTo(quantityLabel.snp.trailing).offset(16)
            }
            
            // 수량 레이블 UI 설정
            quantityLabel.text = "0"
            quantityLabel.font = UIFont(name: "NotoSansKR-Regular", size: 16)
            
            quantityLabel.snp.makeConstraints {
                $0.leading.equalTo(minueButton.snp.trailing).offset(16)
                $0.centerY.equalTo(coffeeImageView.snp.centerY)
            }
           
        }
        
        
        func basicConfigure() {
            statusLabel.text = "장바구니가 비어있습니다."
            statusLabel.font = UIFont(name: "NotoSansKR-Regular", size: 16)
            cartImageView.image = UIImage(named: "shoppingCart")
            // 기본 뷰만 보이게
            [statusLabel, cartImageView].forEach { $0.isHidden = false }
            
            [coffeeImageView, nameLabel, priceLabel, minueButton, plusButton, quantityLabel].forEach { $0.isHidden = true }
            
        }
        func purchaseConfigure(with item: OrderItem) {
            coffeeImageView.image = UIImage(named: item.imageName)
            nameLabel.text = item.name
            priceLabel.text = "\(item.price)원"
            quantityLabel.text = "\(item.quantity)"
            
            [statusLabel, cartImageView].forEach { $0.isHidden = true }
            // 구매 뷰만 보이게
            [coffeeImageView, nameLabel, priceLabel, minueButton, plusButton, quantityLabel].forEach { $0.isHidden = false }
            
        }
    }
}
