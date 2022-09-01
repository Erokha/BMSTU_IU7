//
//  ShoppingBagClientInfoScreen.swift
//  BrandMarketHelper
//
//  Created by kymblc on 05.08.2021.
//

import Foundation
import UIKit
import PinLayout

final class ShoppingBagClientInfoScreen: UIViewController {
	let userNameTextField = BrandTextFieldFactory.assembleTextFieldWithLeftView(placeholder: "Client name")
	let userEmailTextField = BrandTextFieldFactory.assembleTextFieldWithLeftView(placeholder: "Client email")
	let sellButton = BrandButtonFactory.instance.defaultButton(title: "Sell")
	let activityIndicator = UIActivityIndicatorView(style: .large)
	var output: ShoppingBagScreenViewOutput?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layoutUI()
	}
	
	@objc private func onSellButtonClick() {
		let name = userNameTextField.text ?? ""
		let email = userEmailTextField.text ?? ""
		output?.didTapSellButton(
			with: CustumerSerivceDTOItem(
				assistantName: ProfileProvider.instance.unsafeTradingUserSystemName,
				clientName: name,
				clientEmail: email
			)
		)
	}
}

extension ShoppingBagClientInfoScreen {
	func setupUI() {
		setupView()
		setupUserNameTextField()
		setupUserEmailTextField()
		setupSellButton()
		setupActivityIndicator()
	}
	
	func layoutUI() {
		layoutUserNameTextField()
		layoutUserEmailTextField()
		layoutSellButton()
		layoutActivityIndicator()
	}
	
	func setupView() {
		view.backgroundColor = .systemBackground
	}
	
	func setupUserNameTextField() {
		view.addSubview(userNameTextField)
	}
	
	func layoutUserNameTextField() {
		userNameTextField.pin
			.top(5%)
			.left(20)
			.right(20)
			.height(40)
	}
	
	func setupUserEmailTextField() {
		view.addSubview(userEmailTextField)
	}
	
	func layoutUserEmailTextField() {
		userEmailTextField.pin
			.top(to: userNameTextField.edge.bottom).marginTop(20)
			.left(20)
			.right(20)
			.height(40)
	}
	
	func setupSellButton() {
		sellButton.addTarget(self, action: #selector(onSellButtonClick), for: .touchUpInside)
		view.addSubview(sellButton)
	}
	
	func layoutSellButton() {
		sellButton.pin
			.top(to: userEmailTextField.edge.bottom).marginTop(20)
			.left(20)
			.right(20)
			.height(40)
	}
	
	func setupActivityIndicator() {
		activityIndicator.isHidden = true
		view.addSubview(activityIndicator)
	}
	
	func layoutActivityIndicator() {
		activityIndicator.pin
			.top(to: sellButton.edge.bottom).marginTop(10)
			.width(50)
			.height(50)
			.hCenter(to: sellButton.edge.hCenter)
	}
}

extension ShoppingBagClientInfoScreen: ShoppingBagClientInfoViewInput {
	func loadFailed() {
		sellButton.isUserInteractionEnabled = true
		activityIndicator.isHidden = true
		activityIndicator.startAnimating()
	}
	
	func showError(with message: String) {
		let alert = UIAlertController(title: "Ooooops...", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
		present(alert, animated: true)
	}
	
	func startLoading() {
		sellButton.isUserInteractionEnabled = false
		activityIndicator.isHidden = false
		activityIndicator.startAnimating()
	}
	
	func loadSuccess() {
		activityIndicator.isHidden = false
		activityIndicator.stopAnimating()
	}
}
