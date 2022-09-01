import Foundation
import Kingfisher
import UIKit

final class BrandMarketImageProvider {
    static let shared = BrandMarketImageProvider()
    
    private init() { }
    
    func getImage(url: String?, placeholder: UIImage?, completion: @escaping ((Result<UIImage, ImageError>) -> Void)){
        guard let url = URL.init(string: url ?? "") else {
            completion(.failure(.errorLoadingImage))
            return
        }
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let image):
                completion(.success(image.image))
            case .failure( _):
                completion(.failure(.errorLoadingImage))
            }
        }
    }
    
    func clearImageCache() {
        let cache = ImageCache.default
        cache.clearMemoryCache()
    }
}
