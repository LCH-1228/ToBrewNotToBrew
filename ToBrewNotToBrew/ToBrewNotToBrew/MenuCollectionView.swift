//
//  MenuCollectionView.swift
//  ToBrewNotToBrew
//
//  Created by Chanho Lee on 4/7/25.
//
import UIKit
import SnapKit

protocol MenuCollectionViewDelegate: AnyObject {
    func cellTapped(_ index: IndexPath)
}

class MenuCollectionView: UIView {
    
    weak var delegate: MenuCollectionViewDelegate?
    
    let size = UIScreen.main.bounds
    
    var menus = [Menu]()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "메뉴"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "총 0개"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let menuCollectionView: UICollectionView = {
        let size = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = .init(width: (size.width - 52) / 2, height: (size.width / 2) * 1.45)
        layout.sectionInset = UIEdgeInsets(top:0, left: 20, bottom: 0, right: 20)
        
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        layout.footerReferenceSize = CGSize(width: 0, height: 0)
        
        layout.sectionHeadersPinToVisibleBounds = false
        layout.sectionFootersPinToVisibleBounds = false
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("뷰 로딩 완료")
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
        
        configUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setData(menuData: [Menu]) {
        self.menus = menuData
        menuCollectionView.reloadData()
        print("데이터 업데이트 완료")
    }
}

private extension MenuCollectionView {
    
    func configUI() {
        self.backgroundColor = .white
        addOnSubview()
        setConstraints()
    }
    
    func addOnSubview() {
        self.addSubview(titleLabel)
        self.addSubview(countLabel)
        self.addSubview(menuCollectionView)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.leading.equalTo(self.snp.leading).offset(20)
            $0.top.equalTo(self.snp.top)
        }
        
        countLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        
        menuCollectionView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.top.equalTo(titleLabel.snp.bottom).offset(0)
            $0.bottom.equalTo(self.snp.bottom).offset(0)
        }
    }
}

extension MenuCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.nameLabel.text = menus[indexPath.item].name
        cell.priceLabel.text = String(menus[indexPath.item].price)
        cell.menuImage.image = UIImage(named: menus[indexPath.item].image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.cellTapped(indexPath)
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell else { return }
        
        let config = UIImage.SymbolConfiguration(weight: .heavy)
        cell.button.setImage(UIImage(systemName: "minus", withConfiguration: config), for: .normal)
    }
}


protocol MenuCollectionViewCellDelegate: AnyObject {
    func cellTapped(_ cell: MenuCollectionViewCell)
}

class MenuCollectionViewCell: UICollectionViewCell {
    
    weak var cellViewDelegate: MenuCollectionView?
    
    let imageFream: UIView = {
        let imageFrame = UIView()
        imageFrame.backgroundColor = .whiteSmokeImageFrame
        imageFrame.layer.cornerRadius = 15
        return imageFrame
    }()
    
    let menuImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.backgroundColor = .clear
        
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.backgroundColor = .clear
        
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .heavy)
        button.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .mochaBrownAddbutton
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension MenuCollectionViewCell {
    
    func configUI() {
        addOnSubview()
        setConstraints()
    }
    
    func addOnSubview() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CGColor(red: 232, green: 232, blue: 232, alpha: 1)
        
        contentView.addSubview(imageFream)
        imageFream.addSubview(menuImage)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(button)
    }
    
    func setConstraints() {
        imageFream.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(12)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-12)
            $0.top.equalTo(contentView.snp.top).offset(12)
        }
        
        menuImage.snp.makeConstraints {
            $0.leading.equalTo(imageFream.snp.leading).offset(12)
            $0.trailing.equalTo(imageFream.snp.trailing).offset(-12)
            $0.top.equalTo(imageFream.snp.top).offset(12)
            $0.bottom.equalTo(imageFream.snp.bottom).offset(-12)
            $0.center.equalTo(imageFream.snp.center)
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.top.equalTo(imageFream.snp.bottom).offset(20)
            $0.bottom.equalTo(priceLabel.snp.top).offset(-10)
            
        }
        
        priceLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
        button.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.trailing.equalTo(imageFream.snp.trailing).offset(-8)
            $0.bottom.equalTo(imageFream.snp.bottom).offset(-8)
        }
    }
}
