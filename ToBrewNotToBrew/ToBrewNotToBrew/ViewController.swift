import UIKit
import SnapKit

class ViewController: UIViewController, CategoryViewDelegate, MenuCollectionViewDelegate {


    let homeView = HomeView()
    let categoryView = CategoryView()
    let myView = MenuCollectionView()
        
    let menus: [Menu] = [
        Menu(name: "Americano", price: 4300, image: "americano", category: .toBrew),
        Menu(name: "Cappuccino", price: 4500, image: "cappuccino", category: .toBrew),
        Menu(name: "Cream Latte", price: 4600, image: "creamLatte", category: .toBrew),
        Menu(name: "Frappe", price: 4600, image: "frappe", category: .toBrew),
        Menu(name: "Irish Coffee", price: 4800, image: "irishCoffee", category: .toBrew),
        Menu(name: "Latte", price: 4600, image: "latte", category: .toBrew),
        Menu(name: "Macchiato", price: 4800, image: "macchiato", category: .toBrew),
        
        Menu(name: "Cherry Coke", price: 4000, image: "cherryCoke", category: .notToBrew),
        Menu(name: "Coke", price: 4000, image: "coke", category: .notToBrew),
        Menu(name: "Grapefruit Juice ", price: 4800, image: "grapefruitJuice", category: .notToBrew),
        Menu(name: "Green Juice", price: 4800, image: "greenJuice", category: .notToBrew),
        Menu(name: "Ice Tea", price: 4300, image: "iceTea", category: .notToBrew),
        Menu(name: "Lime Juice", price: 4300, image: "limeJuice", category: .notToBrew),
        Menu(name: "Mojito", price: 5000, image: "mojito", category: .notToBrew),
        Menu(name: "Orange Juice", price: 4800, image: "orangeJuice", category: .notToBrew)
    ]
    
    var currentMenu: [Menu] = []
    
    var isToBrew = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("뷰컨 로딩 완료")
        
        view.backgroundColor = .white

        self.view = homeView
        homeView.firstView.addSubview(categoryView)
        homeView.secondView.addSubview(myView)
        
        categoryView.delegate = self
        
        //주입할 데이터 필터링
        currentMenu = menus.filter({$0.category == .toBrew})
        
        //데이터 주입
        myView.setData(menuData: currentMenu)
        
        //collectionView에서 클릭된 cell 확인을 위한 delegate 지정
        myView.delegate = self
        
        categoryView.snp.makeConstraints {
            $0.top.equalTo(homeView.firstView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        myView.snp.makeConstraints {
            $0.top.equalTo(homeView.secondView.snp.top).offset(20)
            $0.leading.equalTo(homeView.secondView.snp.leading)
            $0.trailing.equalTo(homeView.secondView.snp.trailing)
            $0.height.equalTo(1230)
        }
        
        homeView.onOrderButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            let alert = UIAlertController(title: "주문하기", message: "주문을 진행하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            
            self.present(alert, animated: true)
        }
        
    }
    
    func categoryView(_ view: CategoryView, didSelectCategory isToBrew: Bool) {
        switch isToBrew {
        case true:
            currentMenu = menus.filter({$0.category == .toBrew})
            myView.setData(menuData: currentMenu)
        case false:
            currentMenu = menus.filter({$0.category == .notToBrew})
            myView.setData(menuData: currentMenu)
        }
    }
    
    //어떤 cell이 클릭되었는지 출력 장바구니 UITable뷰와 연동 필요
    func cellTapped(_ name: String) {
        print(menus.filter({$0.name == name})[0])
    }

}
