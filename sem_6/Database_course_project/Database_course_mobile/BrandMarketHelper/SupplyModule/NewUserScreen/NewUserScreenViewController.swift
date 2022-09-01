import UIKit
import PinLayout

final class NewUserScreenViewController: UIViewController {
	var output: NewUserScreenViewOutput?
    let systemNameTextField = BrandTextFieldFactory.assembleTextFieldWithLeftView(
        placeholder: "System name"
    )
    let displayNameTextField = BrandTextFieldFactory.assembleTextFieldWithLeftView(
        placeholder: "Displayed name"
    )
    let positionTextField = BrandTextFieldFactory.assembleTextFieldWithLeftView(
        placeholder: "Position"
    )
    var backButton = UIButton()
    let permissionPicker = UIPickerView()
	let registerButton = BrandButtonFactory.instance.defaultButton(title: nil)
    
    
    @objc private func didTapRegisterButton() {
        guard let systemName = systemNameTextField.text,
              let diplayName = displayNameTextField.text,
              let postion = positionTextField.text
        else { return }
        let row = permissionPicker.selectedRow(inComponent: 0)
        guard let permission = permissionPicker.delegate?.pickerView?(permissionPicker, titleForRow: row, forComponent: 0) else { return }
        output?.didTapRegisterButton(
            systemName: systemName,
            displayName: diplayName,
            permission: permission,
            position: postion
        )
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        buildUI()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }
}

extension NewUserScreenViewController {
    private func buildUI() {
        buildView()
        buildSystemNameTextField()
        buildDisplayNameTextField()
        buildPositionTextField()
        buildPermissionPicker()
        buildBackButton()
        buildRegisterButton()
    }
    
    private func layoutUI() {
        layoutSystemNameTextField()
        layoutDisplayNameTextField()
        layoutPositionTextField()
        layoutPermissionPicker()
        layoutBackButton()
        layoutRegisterButton()
    }
    
    private func buildView() {
        view.backgroundColor = .systemBackground
    }
    
    private func buildSystemNameTextField() {
        view.addSubview(systemNameTextField)
    }
    
    private func layoutSystemNameTextField() {
        systemNameTextField.pin
            .left(10)
            .right(10)
            .top(12%)
            .height(40)
    }
    
    private func buildDisplayNameTextField() {
        view.addSubview(displayNameTextField)
    }
    
    private func layoutDisplayNameTextField() {
        displayNameTextField.pin
            .left(10)
            .right(10)
            .top(to: systemNameTextField.edge.bottom).marginTop(20)
            .height(40)
    }
    
    private func buildPositionTextField() {
        view.addSubview(positionTextField)
    }
    
    private func layoutPositionTextField() {
        positionTextField.pin
            .left(10)
            .right(10)
            .top(to: displayNameTextField.edge.bottom).marginTop(20)
            .height(40)
    }
    
    private func buildPermissionPicker() {
        permissionPicker.delegate = self
        permissionPicker.dataSource = self
        view.addSubview(permissionPicker)
    }
    
    private func layoutPermissionPicker() {
        permissionPicker.pin
            .left(20)
            .right(20)
            .height(160)
            .top(to: positionTextField.edge.bottom).marginTop(10)
        permissionPicker.layer.cornerRadius = 10
    }
    
    private func buildBackButton() {
        backButton = BrandButtonFactory.instance.makeBackChevronButton(from: self)
        view.addSubview(backButton)
    }
    
    private func layoutBackButton() {
        backButton.pin
            .width(25)
            .height(25)
            .left(view.pin.safeArea).marginLeft(15)
            .top(view.pin.safeArea).marginTop(10)
    }
    
    private func buildRegisterButton() {
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        registerButton.setTitle("Register", for: .normal)
        view.addSubview(registerButton)
    }
    
    private func layoutRegisterButton() {
        registerButton.pin
            .left(10)
            .right(10)
            .height(40)
            .top(to: permissionPicker.edge.bottom).marginTop(20)
        //registerButton.layer.cornerRadius = 7
    }
}

extension NewUserScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        BrandPermission.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        BrandPermission.allCases[row].rawValue
    }
}

extension NewUserScreenViewController: NewUserScreenViewInput {
}
