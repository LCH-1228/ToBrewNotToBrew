import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    let logoImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        //스플래쉬 배경색 지정
        view.backgroundColor = UIColor(named: "#52371D")
        
        logoImage.image = UIImage(named: "logo")
        // 이미지의 가로세로 비율을 유지하면서 이미지뷰 크기에 맞게 최대한 크게 보여주도록 설정
        logoImage.contentMode = .scaleAspectFit
        
        view.addSubview(logoImage)
        
        // imageView 제약조건
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(274)
            $0.bottom.equalToSuperview().inset(324.17)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
}
