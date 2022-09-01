import UIKit
import PinLayout

protocol ItemCodeInsertable: AnyObject {
	var itemCode: String { get set }
}

final class NewSupplyScreenViewController: UIViewController, ItemCodeInsertable {
    var providedCode: String?
	var output: NewSupplyScreenViewOutput?
    var backButton = UIButton()
    var qrCodeButton = UIButton()
    let codeTextField = UITextField()
    let sizePicker = UIPickerView()
    let amountTextField = UITextField()
	let supplyButton = BrandButtonFactory.instance.defaultButton(title: nil)
    let activityIndicator = UIActivityIndicatorView(style: .large)
	
	var itemCode: String {
		get {
			return codeTextField.text ?? ""
		}
		set {
			codeTextField.text = newValue
			handleNewSearchText()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
        buildUI()
        handleNewSearchText()
	}
    
    override func viewDidLayoutSubviews() {
        layoutUI()
    }
    
    @objc private func handleNewSearchText() {
        output?.codeDidChanged(code: codeTextField.text ?? "")
    }
    
    @objc private func codeTextFieldDidChangeText() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(handleNewSearchText), object: nil)
        self.perform(#selector(handleNewSearchText), with: nil, afterDelay: 0.3)
    }
	
	@objc private func didTapQRButton() {
		output?.didTapQRButton(with: self)
	}
    
    @objc private func didTapSupplyButton() {
        guard let code = codeTextField.text,
              let amount = amountTextField.text,
              ((output?.model.sizes.count) ?? 0) > 0
        else { return }
        let row = sizePicker.selectedRow(inComponent: 0)
        guard let size = sizePicker.delegate?.pickerView?(sizePicker, titleForRow: row, forComponent: 0) else { return }
        output?.didTapSupplyButton(code: code, size: size, amount: amount)
    }
}

extension NewSupplyScreenViewController {
    private func buildUI() {
        buildView()
        buildBackButton()
        buildQRCodeButton()
        buildCodeTextField()
        buildSizePicker()
        buildAmountTextField()
        buildSupplyButton()
        buildActivityIndicator()
        buildGestureRecognizer()
    }
    
    private func layoutUI() {
        layoutBackButton()
        layoutQRCodeButton()
        layoutCodeTextField()
        layoutSizePicker()
        layoutAmountTextField()
        layoutSupplyButton()
        layoutActivityIndicator()
    }
    
    
    private func buildView() {
        view.backgroundColor = .systemBackground
    }
    
    
    private func buildBackButton() {
        self.backButton = BrandButtonFactory.instance.makeBackChevronButton(from: self)
        view.addSubview(backButton)
    }
    
    private func layoutBackButton() {
        backButton.pin
            .width(25)
            .height(25)
            .left(view.pin.safeArea).marginLeft(15)
            .top(view.pin.safeArea).marginTop(10)
    }
    
    private func buildQRCodeButton() {
        self.qrCodeButton = BrandButtonFactory.instance.makeQrCodeButton()
		self.qrCodeButton.addTarget(self, action: #selector(didTapQRButton), for: .touchUpInside)
        view.addSubview(qrCodeButton)
    }
    
    private func layoutQRCodeButton() {
        qrCodeButton.pin
            .width(25)
            .height(25)
            .right(view.pin.safeArea).marginRight(15)
            .top(view.pin.safeArea).marginTop(10)
    }
    
    private func buildCodeTextField() {
        codeTextField.placeholder = "UUID"
        codeTextField.addTarget(self, action: #selector(codeTextFieldDidChangeText), for: .editingChanged)
        codeTextField.backgroundColor = .systemGray3
        codeTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        codeTextField.leftViewMode = .always
        if let code = providedCode {
            codeTextField.insertText(code)
        }
        view.addSubview(codeTextField)
    }
    
    private func layoutCodeTextField() {
        codeTextField.pin
            .left(20)
            .right(20)
            .height(40)
            .top(to: backButton.edge.bottom).marginTop(10)
        codeTextField.layer.cornerRadius = 10
    }
    
    private func buildSizePicker() {
        sizePicker.delegate = self
        sizePicker.dataSource = self
        view.addSubview(sizePicker)
    }
    
    private func layoutSizePicker() {
        sizePicker.pin
            .left(20)
            .right(20)
            .height(160)
            .top(to: codeTextField.edge.bottom).marginTop(10)
        sizePicker.layer.cornerRadius = 10
    }
    
    private func buildAmountTextField() {
        amountTextField.placeholder = "Amount"
        amountTextField.backgroundColor = .systemGray3
        amountTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        amountTextField.leftViewMode = .always
        amountTextField.textColor = .label
        view.addSubview(amountTextField)
    }
    
    private func layoutAmountTextField() {
        amountTextField.pin
            .left(20)
            .right(20)
            .height(40)
            .top(to: sizePicker.edge.bottom).marginTop(10)
        amountTextField.layer.cornerRadius = 10
    }
    
    private func buildSupplyButton() {
        supplyButton.setTitle("Supply", for: .normal)
        supplyButton.addTarget(self, action: #selector(didTapSupplyButton), for: .touchUpInside)
        view.addSubview(supplyButton)
    }
    
    private func layoutSupplyButton() {
        supplyButton.pin
            .left(20)
            .right(20)
            .height(40)
            .top(to: amountTextField.edge.bottom).marginTop(20)
        //supplyButton.layer.cornerRadius = 10
    }
    
    private func buildActivityIndicator() {
        view.addSubview(activityIndicator)
    }
    
    private func layoutActivityIndicator() {
        activityIndicator.pin
            .top(to: supplyButton.edge.bottom).marginTop(70)
            .hCenter()
            .height(50)
            .width(50)
    }
    
    private func buildGestureRecognizer() {
        BrandGestureRecognizerFabric.gestureRecognizerOnEmptyTap(view: self.view)
    }
}

extension NewSupplyScreenViewController: NewSupplyScreenViewInput {
    func startActivityAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityAnimating() {
        activityIndicator.stopAnimating()
    }
    
    func disableSupplyButton() {
        supplyButton.isUserInteractionEnabled = false
    }
    
    func enableSupplyButton() {
        supplyButton.isUserInteractionEnabled = true
    }
    
    func updatePickerData() {
        sizePicker.reloadAllComponents()
        let components = ((output?.model.sizes.count) ?? 0) > 0 ? 1 : 0
        if components > 0 {
            sizePicker.selectRow(0, inComponent: 0, animated: true)
        }
    }
    
}

extension NewSupplyScreenViewController: UITextFieldDelegate {
}

extension NewSupplyScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        ((output?.model.sizes.count) ?? 0) > 0 ? 1 : 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        output?.model.sizes.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (output?.model.sizes.count == 0) || row > (output?.model.sizes.count ?? 0) {
            return ""
        }
        return output?.model.sizes[row]
    }
}
