import UIKit
import SnapKit

class HomeView: UIView {
    
    let headerLogoImage = UIImageView()
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let orderButton = UIButton()
    
    // 뷰를 코드로 만들 때 호출되는 초기화 함수
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // StoryBoard에서 뷰를 만들지 못하도록 에러 처리
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        let firstView = UIView()
        firstView.backgroundColor = .red

        let secondView = UIView()
        secondView.backgroundColor = .green

        let thirdView = UIView()
        thirdView.backgroundColor = .blue
        
        let fourthView = UIView()
        fourthView.backgroundColor = .purple
        
        addSubview(headerLogoImage)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(orderButton)
    
        stackView.addArrangedSubview(firstView)
        stackView.addArrangedSubview(secondView)
        stackView.addArrangedSubview(thirdView)
        stackView.addArrangedSubview(fourthView)
        
        headerLogoImage.image = UIImage(named: "headerLogo")
        headerLogoImage.contentMode = .scaleAspectFit
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        orderButton.backgroundColor = UIColor(named: "#6E1E25")
        orderButton.setTitle("주문하기", for: .normal)
        orderButton.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        orderButton.setTitleColor(.white, for: .normal)
        orderButton.layer.cornerRadius = 30
        
        headerLogoImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(12)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerLogoImage.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(orderButton.snp.top).offset(-12)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        firstView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalTo(headerLogoImage.snp.bottom).offset(12)
        }
        
        secondView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalTo(firstView.snp.bottom)
        }
        
        thirdView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalTo(secondView.snp.bottom)
        }
        
        fourthView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalTo(thirdView.snp.bottom)
        }
        
        orderButton.snp.makeConstraints {
            $0.width.equalTo(320)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }
        
    }
}

