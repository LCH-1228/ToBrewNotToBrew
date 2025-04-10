import UIKit
import SnapKit
   
class ViewController: UIViewController, CategoryViewDelegate, MenuCollectionViewDelegate, MenuSelectionDelegate {
    
    
    
    // 각 뷰 생성
    let orderTableView = TableView()
    let homeView = HomeView()
    let categoryView = CategoryView()
    let myView = MenuCollectionView()
    
    // 비어있는 아이템 배열 생성
    var orderItem: [OrderItem] = []
    var selectedMenu: [String : Int] = [ : ]
        
    let menus: [Menu] = [
        Menu(name: "Americano", price: 4300, image: "americano", quantity: 1, category: .toBrew),
        Menu(name: "Cappuccino", price: 4500, image: "cappuccino", quantity: 1, category: .toBrew),
        Menu(name: "Cream Latte", price: 4600, image: "creamLatte", quantity: 1, category: .toBrew),
        Menu(name: "Frappe", price: 4600, image: "frappe", quantity: 1, category: .toBrew),
        Menu(name: "Irish Coffee", price: 4800, image: "irishCoffee", quantity: 1, category: .toBrew),
        Menu(name: "Latte", price: 4600, image: "latte", quantity: 1, category: .toBrew),
        Menu(name: "Macchiato", price: 4800, image: "macchiato", quantity: 1, category: .toBrew),
        
        Menu(name: "Cherry Coke", price: 4000, image: "cherryCoke", quantity: 1, category: .notToBrew),
        Menu(name: "Coke", price: 4000, image: "coke", quantity: 1, category: .notToBrew),
        Menu(name: "Grapefruit Juice ", price: 4800, image: "grapefruitJuice", quantity: 1, category: .notToBrew),
        Menu(name: "Green Juice", price: 4800, image: "greenJuice", quantity: 1, category: .notToBrew),
        Menu(name: "Ice Tea", price: 4300, image: "iceTea", quantity: 1, category: .notToBrew),
        Menu(name: "Lime Juice", price: 4300, image: "limeJuice", quantity: 1, category: .notToBrew),
        Menu(name: "Mojito", price: 5000, image: "mojito", quantity: 1, category: .notToBrew),
        Menu(name: "Orange Juice", price: 4800, image: "orangeJuice", quantity: 1, category: .notToBrew)
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
        homeView.thirdView.addSubview(orderTableView)
        
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
        
        orderTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
//         더미 데이터를 받아와서 updateOrders 메서드 실행
        orderTableView.updateOrders(orderItem)
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
        let currentselected = menus.filter({$0.name == name})[0]
                
        let item = OrderItem(name: currentselected.name,
                             price: currentselected.price,
                             imageName: currentselected.image,
                             quantity: 1,
                             category: currentselected.category)
        didSelectMenuItem(item)
    }
    
    // 메뉴가 선택될 때 실행되는 메서드
    func didSelectMenuItem(_ item: OrderItem) {
        
        var totalPrice:Int = 0
        
        let currentQuantity = selectedMenu[item.name] ?? 0
        selectedMenu.updateValue(currentQuantity + 1, forKey: item.name)
        
        for ammount in selectedMenu {
            let price = menus.filter({$0.name == ammount.key})[0].price
            let quantity = selectedMenu[ammount.key] ?? 0
            totalPrice += price * quantity
        }
        
        if let index = orderItem.firstIndex(where: { $0.name == item.name}) {
            orderItem[index].quantity += 1
        } else {
            orderItem.append(item)
        }
        
        orderTableView.updateOrders(orderItem)
        homeView.paymentAmountLabel.text = "\(totalPrice)"
        
    }
}
