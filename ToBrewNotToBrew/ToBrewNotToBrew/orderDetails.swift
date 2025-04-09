//
//  orderDetails.swift
//  ToBrewNotToBrew
//
//  Created by 김기태 on 4/8/25.
//

import UIKit
import SnapKit


class TableView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // 셀 등록
        tableView.register(OrderItemCell.self, forCellReuseIdentifier: "OrderItemCell")
        // 테이블 뷰제약 조건
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
    }
}
extension TableView: UITableViewDelegate, UITableViewDataSource {
    // 테이블 뷰 행 개수. 1. 장바구니에 아무것도 없을 때, 2. 장바구니에 담겨있을 때로 구성해야함.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    // 테이블 뷰 내용.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as? OrderItemCell else {
            return UITableViewCell()
        }
        cell.configure()
        return cell
    }
    
    
}

// 테이블 뷰 셀
class OrderItemCell: UITableViewCell {
    let statusLabel = UILabel()
    let cartImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        [statusLabel, cartImageView].forEach {
            contentView.addSubview($0)
        }
        cartImageView.contentMode = .scaleAspectFit
        cartImageView.clipsToBounds = true
        
        cartImageView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.top.equalToSuperview().offset(55)
            $0.bottom.equalToSuperview().offset(81)
            $0.centerX.equalToSuperview()
        }
        
        
        statusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cartImageView.snp.bottom).offset(10)
            
        }
    }
    func configure() {
        statusLabel.text = "장바구니가 비어있습니다."
        cartImageView.image = UIImage(named: "shoppingCart")
    }
}
