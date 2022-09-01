import Foundation
import UIKit

final class BrandTextFieldFactory {
    static func assembleTextFieldWithLeftView(
        placeholder: String? = nil,
        backgroundColor: UIColor = .systemGray2,
        width: Int = 10,
        height: Int = 40
    ) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = backgroundColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        textField.leftViewMode = .always
		textField.autocorrectionType = .no
        return textField
    }
}
