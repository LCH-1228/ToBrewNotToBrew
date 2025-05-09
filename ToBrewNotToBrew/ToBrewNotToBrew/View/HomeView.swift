import UIKit
import SnapKit

class HomeView: UIView {
    
    let headerLogoImage = UIImageView()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let saparator = UIView()
    let paymentTitleLabel = UILabel()
    let paymentAmountLabel = UILabel()
    let orderButton = UIButton()
    var onOrderButtonTapped: (() -> Void)?
    
    let firstView = UIView()
    let secondView = UIView()
    let thirdView = UIView()
    
    var paymentAmount: Int = 0 {
        didSet {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formatted = formatter.string(for: paymentAmount)!
            
            
            paymentAmountLabel.text = "\(formatted) 원"
            
            
            orderButton.isEnabled = paymentAmount > 0
            orderButton.alpha = paymentAmount > 0 ? 1.0 : 0.5
        }
    }
    
    // 뷰를 코드로 만들 때 호출되는 초기화 함수
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    // StoryBoard에서 뷰를 만들지 못하도록 에러 처리
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        
        [headerLogoImage, scrollView, saparator, paymentTitleLabel, paymentAmountLabel, orderButton]
            .forEach { addSubview($0) }
        
        scrollView.addSubview(stackView)
        
        [firstView, secondView, thirdView]
            .forEach { stackView.addArrangedSubview($0) }
        
        
        headerLogoImage.image = UIImage(named: "headingLogo")
        headerLogoImage.contentMode = .scaleAspectFit
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        firstView.backgroundColor = .white
        secondView.backgroundColor = .white
        thirdView.backgroundColor = .white
        
        saparator.backgroundColor = .lightGray
        
        paymentTitleLabel.text = "결제예정금액"
        paymentTitleLabel.textColor = .black
        paymentTitleLabel.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        paymentAmountLabel.textColor = .black
        paymentAmountLabel.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        paymentAmount = 0
        
        orderButton.backgroundColor = .burgundyButton
        orderButton.setTitle("주문하기", for: .normal)
        orderButton.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        orderButton.setTitleColor(.white, for: .normal)
        orderButton.layer.cornerRadius = 30
        
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }
    
    @objc private func orderButtonTapped() {
        onOrderButtonTapped?()
    }
    
    private func setupConstraints() {
        headerLogoImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(12)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerLogoImage.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(paymentTitleLabel.snp.top).offset(-30)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(self)
        }
        
        firstView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        secondView.snp.makeConstraints {
            $0.height.equalTo(1280)
        }
        
        thirdView.snp.makeConstraints {
            $0.top.equalTo(secondView.snp.bottom)
            $0.height.equalTo(1000)
        }
        
        saparator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.2)
            $0.top.equalTo(scrollView.snp.bottom)
        }
        
        paymentTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(orderButton.snp.top).offset(-50)
        }
        
        paymentAmountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(paymentTitleLabel.snp.centerY)
        }
        
        orderButton.snp.makeConstraints {
            $0.width.equalTo(320)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }
    }
}
