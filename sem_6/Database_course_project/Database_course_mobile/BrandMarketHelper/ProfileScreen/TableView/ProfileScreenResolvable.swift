import Foundation
import UIKit

protocol ProfileScreenResolverProtocol {
    func resolve(defaultCell: ProfileScreenDefaultSection)
    func resolve(buttonCell: ProfileScreenButtonSection)
}

protocol ProfileScreenResolvable: UITableViewCell {
    func resolve(using resolver: ProfileScreenResolver)
}

struct ProfileScreenResolver: ProfileScreenResolverProtocol {
    let model: ProfileScreenDefaultSectionModel
    weak var tableView: UITableView?
    let index: IndexPath

    func resolve(defaultCell: ProfileScreenDefaultSection) {
        defaultCell.leftTitle.text = model.infoType
        defaultCell.rightTitle.text = model.title
    }
    
    func resolve(buttonCell: ProfileScreenButtonSection) {
        buttonCell.button.setTitle(model.title, for: .normal)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(model.performAction))
        gestureRecognizer.numberOfTouchesRequired = 1
        buttonCell.button.addGestureRecognizer(gestureRecognizer)
//        buttonCell.button.addAction {
//            model.action?()
//        }
    }
    
}

extension ProfileScreenResolver {
    func resolve() -> UITableViewCell {
        switch model.style {
        case .buttonCell:
            guard let cell = tableView?.dequeueReusableCell(
                    withIdentifier: ProfileScreenButtonSection.reuseIdentifier, for: index
            ) as? ProfileScreenButtonSection else {
                return UITableViewCell()
            }
            cell.resolve(using: self)
            return cell
        case .defaultCell:
            guard let cell = tableView?.dequeueReusableCell(
                    withIdentifier: ProfileScreenDefaultSection.reuseIdentifier, for: index
            ) as? ProfileScreenDefaultSection else {
                return UITableViewCell()
            }
            cell.resolve(using: self)
            return cell
        }
    }
}
 
