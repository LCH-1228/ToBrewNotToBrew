//
//  MenuCollectionView.swift
//  ToBrewNotToBrew
//
//  Created by Chanho Lee on 4/7/25.
//
import UIKit
import SnapKit

protocol MenuCollectionViewDelegate: AnyObject {
    func cellTapped(_ name: String)
}

class MenuCollectionView: UIView {
    
    weak var delegate: MenuCollectionViewDelegate?
    
    let size = UIScreen.main.bounds
    
    var menus = [Menu]()
    
    let menuCollectionView: UICollectionView = {
        let size = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = .init(width: (size.width - 52) / 2, height: (size.width / 2) * 1.45)
        layout.sectionInset = UIEdgeInsets(top:20, left: 20, bottom: 0, right: 20)
        
        layout.headerReferenceSize = CGSize(width: size.width, height: 20)
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
        menuCollectionView.register(MenuCollectionViewHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: "header")
        
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
        addOnSubview()
        setConstraints()
    }
    
    func addOnSubview() {
        self.addSubview(menuCollectionView)
    }
    
    func setConstraints() {
        menuCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell else { return }
        
        delegate?.cellTapped(cell.nameLabel.text ?? "실패")
        
        let config = UIImage.SymbolConfiguration(weight: .heavy)
        cell.button.setImage(UIImage(systemName: "minus", withConfiguration: config), for: .normal)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? MenuCollectionViewHeaderView else { return UICollectionReusableView() }
            return headerView
    }
}

class MenuCollectionViewCell: UICollectionViewCell {
    
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
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.backgroundColor = .clear
        
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
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
        contentView.layer.borderColor = CGColor(red: 0.9098, green: 0.9098, blue: 0.9098, alpha: 1)
        
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


class MenuCollectionViewHeaderView: UICollectionReusableView {
        
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "메뉴"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Bold", size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configUI() {
        addOnSubview()
        makeConstrainst()
    }
    
    func addOnSubview() {
        self.addSubview(titleLabel)
    }
    
    func makeConstrainst() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview()
        }
    }
}
