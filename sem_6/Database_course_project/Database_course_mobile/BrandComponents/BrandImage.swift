import Foundation
import UIKit

public enum BrandImage {
    case chevronLeft
    case settingsSlider
    case box
    case searchGlass
    case qrcode
    case person
    case avatarPlaceholder
	case shoppingBag
}

extension BrandImage {
    var imageName: String {
        switch self {
        case .chevronLeft:
            return "chevron.left"
        case .settingsSlider:
            return "filer"
        case .qrcode:
            return "qrcode"
        case .person:
            return "person"
        case .box:
            return "cube.box"
        case .searchGlass:
            return "magnifyingglass"
        case .avatarPlaceholder:
            return "person.crop.circle.fill"
		case .shoppingBag:
			return "bag.fill"
        }
    }
}


extension BrandImage {
    var image: UIImage? {
        if let image =  UIImage(systemName: self.imageName) {
            return image
        }
        if let image = UIImage(named: self.imageName) {
            return image
        }
        return nil
    }
}
