import UIKit
import SnapKit

class ViewController: UIViewController, CategoryViewDelegate {

    private let categoryView = CategoryView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(categoryView)
        categoryView.delegate = self
        
        categoryView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
    }
    
    func categoryView(_ view: CategoryView, didSelectCategory isToBrew: Bool) {
        // 이 안에서 메뉴 데이터는 찬호님이 처리할 예정
        print("선택된 카테고리: \(isToBrew ? "To Brew" : "Not To Brew")")
    }
}
