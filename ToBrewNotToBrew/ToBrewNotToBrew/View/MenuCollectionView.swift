//
//  MenuCollectionView.swift
//  ToBrewNotToBrew
//
//  Created by Chanho Lee on 4/7/25.
//
import UIKit
import SnapKit

// 메뉴 셀 터치 이벤트를 전달하기 위한 델리게이트 프로토콜
protocol MenuCollectionViewDelegate: AnyObject {
    func cellTapped(_ name: String)
}

/// 메뉴를 컬렉션 뷰를 표시하는 는 커스텀 뷰 클래스
class MenuCollectionView: UIView {
    
    /// 셀 터치 이벤트를 위한 delegate
    weak var delegate: MenuCollectionViewDelegate?
    
    /// 메뉴 데이터 배열(값 설정시 컬렉션 뷰 데이터 재로딩)
    var menus = [Menu]() {
        didSet {
            menuCollectionView.reloadData()
        }
    }
    
    /// 메뉴를 표시할 UICollectionView 인스턴스 생성 및 초기 설정
    let menuCollectionView: UICollectionView = {
        
        /// 현재 화면 크기를 저장 (레이아웃 계산에 사용)
        let size = UIScreen.main.bounds
        
        // 컬렉션뷰 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 세로로 셀 배치
        layout.minimumLineSpacing = 12 // 셀 사이 최소 세로 간격
        layout.minimumInteritemSpacing = 12 // 셀 사이 최소 가로 간격
        
        layout.itemSize = .init(width: (size.width - 52) / 2, height: (size.width / 2) * 1.45) // 셀 크기 계산 (전체 화면 너비에서 좌우 여백 20과 셀사이 간격 12를 뺀 값으로 2열로 배치)
        layout.sectionInset = UIEdgeInsets(top:20, left: 20, bottom: 0, right: 20) //컬렉션 뷰 좌우 여백 20 설정
        
        layout.headerReferenceSize = CGSize(width: size.width, height: 20) // 헤더 사이즈 20 설정
        layout.footerReferenceSize = CGSize(width: 0, height: 0) // 푸터 사이즈 0 설정
        
        // UICollectionView 인스턴스 생성 및 기본 설정
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white // 배경색 흰색 설정
        collectionView.isScrollEnabled = false // 스크롤 비활성화
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("뷰 로딩 완료")
        
        // 컬렉션 뷰 델리게이트 및 데이터소스 설정
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        // 컬렉션 뷰 헤더 뷰 등록
        menuCollectionView.register(MenuCollectionViewHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: "header")
        
        // 컬렉션 뷰 메뉴 셀 등록
        menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
        
        configUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension MenuCollectionView {
    
    // UI 설정 메서드 호출 (뷰에 서브뷰 추가 및 제약 설정)
    func configUI() {
        addOnView()
        setConstraints()
    }
    
    // 뷰에 서브뷰를 추가하는 메서드
    func addOnView() {
        self.addSubview(menuCollectionView)
    }
    
    // 제약 설정 메서드
    func setConstraints() {
        menuCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MenuCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// 메뉴 배열의 셀 개수를 반환 (필수 구현 메서드)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    /// 셀을 구성하여 컬렉션뷰에 반환(필수 구현 메서드)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 커스텀 셀을 타입캐스팅하여 가져옴
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        // 메뉴 가격에 천단위 구분기호를 위한 포맷터 설정
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formatted = formatter.string(from: NSNumber(value: menus[indexPath.item].price)) ?? "0"
        
        // 메뉴에 따라 셀 내 라벨 및 이미지 설정
        cell.nameLabel.text = menus[indexPath.item].name
        cell.priceLabel.text = "\(formatted)원"
        cell.menuImage.image = UIImage(named: menus[indexPath.item].image)
        
        return cell
    }
    
    /// 셀이 선택되었을 때 호출되는 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 선택된 셀을 타입 캐스팅하여 가져옴
        guard let cell = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell else { return }
        
        // delegate를 이용하여 선택된 셀의 이름을 전달
        delegate?.cellTapped(cell.nameLabel.text ?? "실패")
    }
    
    /// 헤더 뷰를 컬렉션 뷰로 반환하는 메서드
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? MenuCollectionViewHeaderView else { return UICollectionReusableView() }
            return headerView
    }
}

/// 메뉴 정보를 표시하는 커스텀 셀 클래스
class MenuCollectionViewCell: UICollectionViewCell {
    
    /// 이미지 표시를 위한 프레임 뷰 (배경 역할)
        let imageFrame: UIView = {
        let imageFrame = UIView()
        imageFrame.backgroundColor = .whiteSmokeImageFrame
        imageFrame.layer.cornerRadius = 15
        return imageFrame
    }()
    
    /// 메뉴 이미지를 표시하는 이미지 뷰
    let menuImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // 메뉴 이름을 표시하는 라벨
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.backgroundColor = .clear
        
        return label
    }()
    
    // 메뉴 가격을 표시하는 라벨
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.backgroundColor = .clear
        
        return label
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
    
    // UI 설정 메서드 호출 (컨텐츠뷰에 추가 및 제약 설정)
    func configUI() {
        addOnContentView()
        setConstraints()
    }
    
    /// 셀의 컨텐츠 뷰에 서브뷰를 추가하는 메서드
    func addOnContentView() {
        
        // 컨텐츠뷰 기본 값 설정
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CGColor(red: 0.9098, green: 0.9098, blue: 0.9098, alpha: 1)
        
        //이미지 프로엠 및 메뉴 이미지 추가
        contentView.addSubview(imageFrame)
        imageFrame.addSubview(menuImage)
        
        //라밸과 버튼 추가
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
    }
    
    // 제약설정 메서드
    func setConstraints() {
        
        // 이미지 프레임 제약 설정
        imageFrame.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(12)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-12)
            $0.top.equalTo(contentView.snp.top).offset(12)
        }
        
        // 메뉴 이미지 제약 설정
        menuImage.snp.makeConstraints {
            $0.leading.equalTo(imageFrame.snp.leading).offset(12)
            $0.trailing.equalTo(imageFrame.snp.trailing).offset(-12)
            $0.top.equalTo(imageFrame.snp.top).offset(12)
            $0.bottom.equalTo(imageFrame.snp.bottom).offset(-12)
        }
        
        //메뉴 이름 제약 설정
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.top.equalTo(imageFrame.snp.bottom).offset(20)
            $0.bottom.equalTo(priceLabel.snp.top).offset(-10)
            
        }
        
        // 메뉴 가격 제약 설정
        priceLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }
}

// 컬렉션 뷰의 헤더 역할을 하는 보조 뷰 클래스
class MenuCollectionViewHeaderView: UICollectionReusableView {
    
    // 헤더에 표시할 라벨
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
    
    // UI 설정 메서드 호출 (보조뷰에 추가 및 제약 설정)
    func configUI() {
        addOnView()
        makeConstraints()
    }
    
    /// 보조뷰에 서브뷰를 추가하는 메서드
    func addOnView() {
        self.addSubview(titleLabel)
    }
    
    // 제약 설정 메서드
    func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview()
        }
    }
}
