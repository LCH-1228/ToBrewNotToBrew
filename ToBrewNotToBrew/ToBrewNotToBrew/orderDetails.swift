//
//  orderDetails.swift
//  ToBrewNotToBrew
//
//  Created by 김기태 on 4/8/25.
//

import UIKit
import SnapKit

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
        }
        
        statusLabel.text = "장바구니가 비어있습니다."
        statusLabel.font = .systemFont(ofSize: 14)
        
        statusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cartImageView.snp.bottom).offset(10)
            
        }
    }
    func configure() {
        
    }
}
