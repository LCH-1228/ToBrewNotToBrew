//
//  orderDetails.swift
//  ToBrewNotToBrew
//
//  Created by 김기태 on 4/8/25.
//

import UIKit
import SnapKit

protocol MenuSelectionDelegate: AnyObject {
    func didSelectMenuItem(_ item: OrderItem)
}


class TableView: UIView {
    
    let shoppingCart = UILabel() // 장바구니 레이블
    let totalCountLabel = UILabel()
    let tableView = UITableView()
    
    var TrashTapped: (() -> Void)? //viewcontroller로 이벤트 전달을 위한 클로저
    // tableviewheader -> tablevoew -> viewcontroller 로 이벤트를 전달하기 위한 중간다리 역할을 함
    
    var plusButtonAction: ((Int) -> Void)?
    var minuesButtonAction: ((Int) -> Void)?
    
    var totalCount: Int = 0 {
        didSet {
            totalCountLabel.text = "총 \(totalCount) 개"
        }
    }
    func updateTotalCount() {
        let total = orderItems.reduce(0) { $0 + $1.quantity}
        totalCount = total
    }
    func totalCountUI() {
        addSubview(totalCountLabel)
//        totalCountLabel.text = "총 \(totalCount) 개"
        totalCountLabel.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        
        totalCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview()

        }
    }
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

    // didSet을 통해서 값을 갱신해줌.
    var orderItems: [OrderItem] = [] {
        didSet {
            tableView.reloadData()
            updateTotalCount()

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
        tableView.isScrollEnabled = false
        totalCountUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shoppingCartUI()
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 15
        tableView.backgroundColor = .whiteSmokeImageFrame
        tableView.sectionHeaderHeight = 52.0
        
        // 셀 등록
        tableView.register(OrderItemCell.self, forCellReuseIdentifier: "OrderItemCell")
        // 테이블 뷰제약 조건
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.top.equalTo(shoppingCart.snp.bottom).offset(20)
        }
        
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: "headerView")
        
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
        cell.backgroundColor = .whiteSmokeImageFrame
        
        if orderItems.count == 0 {
            cell.basicConfigure()
            tableView.separatorStyle = .none
        } else {
            let item = orderItems[indexPath.row]
            cell.purchaseConfigure(with: item)
            tableView.separatorStyle = .singleLine
            
            cell.plusButtonTapped = { [weak self] in
                guard let self = self else { return }
                self.plusButtonAction?(indexPath.row) // viewcontroller로 몇 번째 셀인지 전달
            }

            cell.minueButtonTapped = { [weak self] in
                guard let self = self else { return }
                self.minuesButtonAction?(indexPath.row)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView") as? TableViewHeader else { return UIView() }
        
        headerView.tapped = { [weak self] in
            self?.TrashTapped?()
            //tableviewheader에 정의된 tapped클로저에 tableview가 가지고 있는 trashtapped 클로저를 연결
        }
        
        return headerView
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
    
    var plusButtonTapped: (() -> Void)?
    var minueButtonTapped: (() -> Void)?
    
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
        minueButton.addTarget(self, action: #selector(minueTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        
        // 카트 이미지 UI 설정
        cartImageView.contentMode = .scaleAspectFit
        cartImageView.clipsToBounds = true
        
        cartImageView.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.centerY.equalTo(contentView.snp.centerY).offset(-20)
        }
        
        // 기본상태(주문내역x) 레이블 UI 설정
        statusLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.centerY.equalTo(contentView.snp.centerY).offset(20)
        }
        
        // 커피 이미지 UI 설정
        coffeeImageView.contentMode = .scaleAspectFit
        coffeeImageView.clipsToBounds = true
        coffeeImageView.backgroundColor = .white
        
        coffeeImageView.snp.makeConstraints {
            $0.width.height.equalTo(64)
            $0.top.equalToSuperview().offset(16)
            
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
    @objc func plusTapped() {
        plusButtonTapped?() //tableview로 이벤트 전달
    }

    @objc func minueTapped() {
        minueButtonTapped?()
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

class TableViewHeader: UITableViewHeaderFooterView {
    
    var tapped: (() -> Void)?
    // viewcontroller에게 전달할 클로저(버튼을 눌렀을 때 수행할 동작을 viewcontroller에서 정의할 수 있게 함
    
    @objc func trashButtonTapped() { //버튼 클릭시 실행되는 함수
        tapped?() // viewcontroller로 이벤트 전달 + viewcontroller가 정의해둔 tapped 클로저 실행
    }
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Trash"), for: .normal)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: "headerView")
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configUI() {
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(0)
        }
        
        button.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
    }
}
