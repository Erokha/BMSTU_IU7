import Foundation
import UIKit

protocol ImageProviderType {
    var shared: ImageProviderType { get }
    func getImage(url: String, placeholder: UIImage?) -> UIImage?
    func clearImageCache()
}
