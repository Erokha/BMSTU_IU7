import Foundation
import UIKit

protocol ProfileScreenHeightResolverProtocol {
    func resolveHeight(defaultCell: ProfileScreenDefaultSection) -> CGFloat
    func resolveHeight(buttonCell: ProfileScreenButtonSection) -> CGFloat
}

protocol ProfileScreenHeightResolvable: UITableViewCell {
    func resolveHeight(using resolver: ProfileScreenHeightResolver) -> CGFloat
}

struct ProfileScreenHeightResolver: ProfileScreenHeightResolverProtocol {
    func resolveHeight(cell: ProfileScreenHeightResolvable) -> CGFloat {
        return cell.resolveHeight(using: self)
    }
    
    func resolveHeight(defaultCell: ProfileScreenDefaultSection) -> CGFloat {
        return 80
    }
    
    func resolveHeight(buttonCell: ProfileScreenButtonSection) -> CGFloat {
        return 70
    }
    
    
}
