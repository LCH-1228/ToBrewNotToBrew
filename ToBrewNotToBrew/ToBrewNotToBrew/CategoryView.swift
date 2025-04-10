import UIKit
import SnapKit

protocol CategoryViewDelegate: AnyObject {
    func categoryView(_ view: CategoryView, didSelectCategory isToBrew: Bool)
}

class CategoryView: UIView {

    weak var delegate: CategoryViewDelegate?

    private let toggleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 26
        view.clipsToBounds = false
        return view
    }()

    private let toBrewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("To Brew", for: .normal)
        button.layer.cornerRadius = 26
        button.clipsToBounds = false
        return button
    }()

    private let notToBrewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Not To Brew", for: .normal)
        button.layer.cornerRadius = 26
        button.clipsToBounds = false
        return button
    }()

    private var isToBrewSelected = true {
        didSet { updateToggleState() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        setupActions()
        updateToggleState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(toggleBackgroundView)
        toggleBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(28)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(28)
            make.height.equalTo(52)
        }

        toggleBackgroundView.addSubview(toBrewButton)
        toggleBackgroundView.addSubview(notToBrewButton)

        toBrewButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(toggleBackgroundView.snp.centerX)
        }

        notToBrewButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(toggleBackgroundView.snp.centerX)
            make.trailing.equalToSuperview()
        }
    }

    private func setupActions() {
        toBrewButton.addTarget(self, action: #selector(didTapToBrew), for: .touchUpInside)
        notToBrewButton.addTarget(self, action: #selector(didTapNotToBrew), for: .touchUpInside)
    }

    @objc private func didTapToBrew() {
        guard !isToBrewSelected else { return }
        isToBrewSelected = true
        delegate?.categoryView(self, didSelectCategory: true)
    }

    @objc private func didTapNotToBrew() {
        guard isToBrewSelected else { return }
        isToBrewSelected = false
        delegate?.categoryView(self, didSelectCategory: false)
    }

    private func updateToggleState() {
        let selectedColor = UIColor.white
        let unselectedColor = UIColor.clear
        let selectedTextColor = UIColor(red: 0.29, green: 0.18, blue: 0.17, alpha: 1.0)
        let unselectedTextColor = UIColor.lightGray

        if isToBrewSelected {
            toBrewButton.backgroundColor = selectedColor
            toBrewButton.setTitleColor(selectedTextColor, for: .normal)
            toBrewButton.titleLabel?.font = .boldSystemFont(ofSize: 18)

            notToBrewButton.backgroundColor = unselectedColor
            notToBrewButton.setTitleColor(unselectedTextColor, for: .normal)
            notToBrewButton.titleLabel?.font = .systemFont(ofSize: 14)

            applyShadow(to: toBrewButton)
            removeShadow(from: notToBrewButton)
        } else {
            notToBrewButton.backgroundColor = selectedColor
            notToBrewButton.setTitleColor(selectedTextColor, for: .normal)
            notToBrewButton.titleLabel?.font = .boldSystemFont(ofSize: 18)

            toBrewButton.backgroundColor = unselectedColor
            toBrewButton.setTitleColor(unselectedTextColor, for: .normal)
            toBrewButton.titleLabel?.font = .systemFont(ofSize: 14)

            applyShadow(to: notToBrewButton)
            removeShadow(from: toBrewButton)
        }
    }

    private func applyShadow(to button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
    }

    private func removeShadow(from button: UIButton) {
        button.layer.shadowOpacity = 0
    }
}
