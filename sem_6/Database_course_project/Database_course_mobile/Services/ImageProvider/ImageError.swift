import Foundation

enum ImageError: Error {
    case errorLoadingImage
}

extension ImageError {
    var localizedDescrpition: String {
        switch self {
        case .errorLoadingImage:
            return "Error wile loading image"
        }
    }
}
