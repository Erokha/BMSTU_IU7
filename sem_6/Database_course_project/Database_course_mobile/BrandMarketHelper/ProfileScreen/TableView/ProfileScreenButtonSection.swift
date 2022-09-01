import Foundation
import UIKit
import PinLayout

final class ProfileScreenButtonSection: UITableViewCell {
    let button = BrandButtonFactory.instance.defaultButton(title: nil)
    static let reuseIdentifier = "ProflieScreenButtonSection"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        buildUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }
    
    private func buildUI() {
        buildView()
        buildButton()
    }
    
    private func layoutUI() {
        layoutButton()
    }
    
    private func buildView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func buildButton() {
        addSubview(button)
    }
    
    private func layoutButton() {
        button.pin
            .all()
            .margin(3%)
    }
}

extension ProfileScreenButtonSection: ProfileScreenResolvable {
    func resolve(using resolver: ProfileScreenResolver) {
        resolver.resolve(buttonCell: self)
    }
}

extension ProfileScreenButtonSection: ProfileScreenHeightResolvable {
    func resolveHeight(using resolver: ProfileScreenHeightResolver) -> CGFloat {
        return resolver.resolveHeight(buttonCell: self)
    }
}
