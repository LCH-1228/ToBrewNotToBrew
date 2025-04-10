import UIKit
import SnapKit

protocol CategoryViewDelegate: AnyObject {
    func categoryView(_ view: CategoryView, didSelectCategory isToBrew: Bool)
}

class CategoryView: UIView {

    weak var delegate: CategoryViewDelegate?

    private enum CategoryType {
        case toBrew
        case notToBrew
    }

    private struct UI {
        static let selectedColor = UIColor.white
        static let unselectedColor = UIColor.clear
        static let selectedTextColor = UIColor(red: 0.29, green: 0.18, blue: 0.17, alpha: 1.0)
        static let unselectedTextColor = UIColor.lightGray
    }

    private let toggleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 26
        view.clipsToBounds = false
        return view
    }()

    private lazy var toBrewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("To Brew", for: .normal)
        button.layer.cornerRadius = 26
        button.clipsToBounds = false
        return button
    }()

    private lazy var notToBrewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Not To Brew", for: .normal)
        button.layer.cornerRadius = 26
        button.clipsToBounds = false
        return button
    }()

    private var selectedType: CategoryType = .toBrew {
        didSet { updateUI() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        setupActions()
        updateUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(toggleBackgroundView)
        toggleBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().inset(28)
            make.height.equalTo(52)
        }

        toggleBackgroundView.addSubview(toBrewButton)
        toggleBackgroundView.addSubview(notToBrewButton)

        toBrewButton.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalTo(toggleBackgroundView.snp.centerX)
        }

        notToBrewButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(toggleBackgroundView.snp.centerX)
        }
    }

    private func setupActions() {
        toBrewButton.addTarget(self, action: #selector(didTapToBrew), for: .touchUpInside)
        notToBrewButton.addTarget(self, action: #selector(didTapNotToBrew), for: .touchUpInside)
    }

    @objc private func didTapToBrew() {
        guard selectedType != .toBrew else { return }
        selectedType = .toBrew
        delegate?.categoryView(self, didSelectCategory: true)
    }

    @objc private func didTapNotToBrew() {
        guard selectedType != .notToBrew else { return }
        selectedType = .notToBrew
        delegate?.categoryView(self, didSelectCategory: false)
    }

    private func updateUI() {
        updateButtonUI(button: toBrewButton, isSelected: selectedType == .toBrew)
        updateButtonUI(button: notToBrewButton, isSelected: selectedType == .notToBrew)
    }

    private func updateButtonUI(button: UIButton, isSelected: Bool) {
        button.backgroundColor = isSelected ? UI.selectedColor : UI.unselectedColor
        button.setTitleColor(isSelected ? UI.selectedTextColor : UI.unselectedTextColor, for: .normal)
        button.titleLabel?.font = isSelected ? .boldSystemFont(ofSize: 18) : .systemFont(ofSize: 14)
        button.layer.shadowOpacity = isSelected ? 0.1 : 0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
    }
}
