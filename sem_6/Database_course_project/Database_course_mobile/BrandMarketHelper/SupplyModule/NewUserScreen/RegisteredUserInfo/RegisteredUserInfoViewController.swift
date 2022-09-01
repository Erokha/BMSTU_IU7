import Foundation
import PinLayout
import UIKit

final class RegisteredUserInfoViewController: UIViewController {
    let userNameLabel = UILabel()
    let passwordLabel = UILabel()
    let mainLabel = UILabel()
    
    init(with model: BrandUserDTO) {
        super.init(nibName: nil, bundle: nil)
        self.buildUI(with: model)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }
    
    private func buildUI(with model: BrandUserDTO) {
        view.backgroundColor = .systemBackground
        buildMainLabel(with: "Please, safe this info for your new Employee\n(take a screeenshot or something like that)")
        buildUserNameLabel(with: model.username)
        buildPasswordLabel(with: model.password)
    }
    
    private func layoutUI() {
        layoutMainLabel()
        layoutUserNameLabel()
        layoutPasswordLabel()
    }
    
    private func buildMainLabel(with name: String) {
        mainLabel.text = name
        mainLabel.textColor = .label
        mainLabel.numberOfLines = 0
        mainLabel.lineBreakMode = .byWordWrapping
        mainLabel.textAlignment = .justified
        mainLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .regular)
        view.addSubview(mainLabel)
    }
    
    private func layoutMainLabel() {
        mainLabel.pin
            .top(7%)
            .left(10)
            .right(10)
            .height(140)
    }
    
    private func buildUserNameLabel(with name: String) {
        userNameLabel.text = "Username: \(name)"
        userNameLabel.textColor = .label
        userNameLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 25, weight: .regular)
        view.addSubview(userNameLabel)
    }
    
    private func layoutUserNameLabel() {
        userNameLabel.pin
            .top(to: mainLabel.edge.bottom).marginTop(20)
            .left(10)
            .right(10)
            .height(40)
    }
    
    private func buildPasswordLabel(with password: String) {
        passwordLabel.text = "Password: \(password)"
        passwordLabel.textColor = .label
        passwordLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 25, weight: .regular)
        view.addSubview(passwordLabel)
    }
    
    private func layoutPasswordLabel() {
        passwordLabel.pin
            .top(to: userNameLabel.edge.bottom).marginTop(20)
            .left(10)
            .right(10)
            .height(40)
    }
    
}
