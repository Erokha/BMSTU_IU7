import UIKit
import PinLayout

final class AuthScreenViewController: UIViewController {
	var output: AuthScreenViewOutput?
    let userNameTextField = UITextField()
    let passwordNameTextField = UITextField()
	let signInButton = BrandButtonFactory.instance.defaultButton(title: "Sign in")
    let activityIndicator = UIActivityIndicatorView(style: .large)

	override func viewDidLoad() {
		super.viewDidLoad()
        buildUI()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }
    
    @objc private func didTapSignInButton() {
        let username = userNameTextField.text ?? ""
        let password = passwordNameTextField.text ?? ""
        signInButton.isUserInteractionEnabled = false
        output?.didTapSingInButton(username: username, password: password)
    }
}

extension AuthScreenViewController: AuthScreenViewInput {
    func startAwait() {
        activityIndicator.startAnimating()
    }
    
    func stopAwait() {
        activityIndicator.stopAnimating()
        signInButton.isUserInteractionEnabled = true
    }
    
}

extension AuthScreenViewController {
    private func buildUI() {
        buildView()
        buildUserNameTextField()
        buildPasswordTextField()
        buildSignInButton()
        buildActivityIndicator()
    }
    
    private func layoutUI() {
        layoutUserNameTextField()
        layoutPasswordTextField()
        layoutSignInButton()
        layoutActivityIndicator()
    }
    
    private func buildView() {
        view.backgroundColor = .systemBackground
    }
    
    private func buildUserNameTextField() {
        userNameTextField.placeholder = "username"
        userNameTextField.backgroundColor = .systemGray2
        userNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        userNameTextField.leftViewMode = .always
        userNameTextField.autocapitalizationType = .none
        userNameTextField.autocorrectionType = .no
        view.addSubview(userNameTextField)
    }
    
    private func layoutUserNameTextField() {
        userNameTextField.pin
            .left(20)
            .right(20)
            .height(45)
            .top(10%).marginTop(20)
        userNameTextField.layer.cornerRadius = 7
    }
    
    private func buildPasswordTextField() {
        passwordNameTextField.placeholder = "password"
        passwordNameTextField.isSecureTextEntry = true
        passwordNameTextField.backgroundColor = .systemGray2
        passwordNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        passwordNameTextField.leftViewMode = .always
        view.addSubview(passwordNameTextField)
    }
    
    
    private func layoutPasswordTextField() {
        passwordNameTextField.pin
            .left(20)
            .right(20)
            .height(45)
            .top(to: userNameTextField.edge.bottom).marginTop(30)
        passwordNameTextField.layer.cornerRadius = 7
    }
    
    private func buildSignInButton() {
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        view.addSubview(signInButton)
    }
    
    private func layoutSignInButton() {
        signInButton.pin
            .left(20)
            .right(20)
            .height(40)
            .top(to: passwordNameTextField.edge.bottom).marginTop(30)
        //signInButton.layer.cornerRadius = 10
    }
    
    private func buildActivityIndicator() {
        view.addSubview(activityIndicator)
    }
    
    private func layoutActivityIndicator() {
        activityIndicator.pin
            .width(50)
            .height(50)
            .hCenter()
            .top(to: signInButton.edge.bottom).marginTop(20)
    }
}
