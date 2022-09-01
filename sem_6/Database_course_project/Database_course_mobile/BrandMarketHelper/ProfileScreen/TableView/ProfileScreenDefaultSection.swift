import Foundation
import UIKit
import PinLayout

final class ProfileScreenDefaultSection: UITableViewCell {
    let leftTitle = UILabel()
    let rightTitle = UILabel()
    
    static let reuseIdentifier = "ProflieScreenDefaultSection"
    
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
        buildLeftTitle()
        buildRightTitle()
    }
    
    private func layoutUI() {
        layoutLeftTitle()
        layoutRightTitle()
    }
    
    private func buildView() {
		backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func buildLeftTitle() {
        leftTitle.textColor = .label
        addSubview(leftTitle)
    }
    
    private func layoutLeftTitle() {
        leftTitle.pin
            .all()
            .marginRight(50%)
            .marginTop(5%)
            .marginBottom(5%)
    }
    
    private func buildRightTitle() {
        rightTitle.textColor = .label
        addSubview(rightTitle)
    }
    
    private func layoutRightTitle() {
        rightTitle.pin
            .all()
            .marginLeft(50%)
            .marginTop(5%)
            .marginBottom(5%)
    }
}

extension ProfileScreenDefaultSection: ProfileScreenResolvable {
    func resolve(using resolver: ProfileScreenResolver) {
        resolver.resolve(defaultCell: self)
    }
}

extension ProfileScreenDefaultSection: ProfileScreenHeightResolvable {
    func resolveHeight(using resolver: ProfileScreenHeightResolver) -> CGFloat {
        return resolver.resolveHeight(defaultCell: self)
    }
}
