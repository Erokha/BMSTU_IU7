import Foundation

enum ProfileCellType {
    case defaultCell
    case buttonCell
}

public class ProfileScreenDefaultSectionModel {
    let infoType: String?
    let title: String
    let action: (() -> Void)?
    let style: ProfileCellType
    
    init(
        infoType: String?,
        title: String,
        action: (() -> Void)?,
        style: ProfileCellType
    ) {
        self.infoType = infoType
        self.title = title
        self.action = action
        self.style = style
    }
    
    @objc func performAction() {
        self.action?()
    }
}
