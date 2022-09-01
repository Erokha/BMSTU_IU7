import Foundation
import Alamofire

final class BrandAPIConverter {
    static func convertProductModelToSearchScreenItemModel(model: ProductDTOModel) -> SearchScreenItemModel {
        SearchScreenItemModel(
            brand: model.brand,
            price: model.price,
            itemName: model.name,
            imageURL: model.imageURL,
            type: model.type.rawValue,
            code: model.code,
            avaliable: model.sizes?.count ?? 0 > 0
        )
    }
    
    static func converProductModelToDetailScreenModel(model: ProductDTOModel) -> DetailScreenModel {
        DetailScreenModel(
            code: model.code,
            name: model.name,
            price: model.price,
            type: model.type.rawValue,
			sizes: model.sizes?.map { DetailScreenStockSize(size: $0.size, amount: $0.amount, inShoppingBag: nil) } ?? [],
            brand: model.brand,
            imageURL: model.imageURL?.absoluteString
        )
    }
    
    static func convertDTOProvidedSizesToDomain(model: DTOProvidedSizes) -> ProvidedSizes {
        ProvidedSizes(
            sizes: model.sizes
        )
    }
    
    static func convertDTOBrandUserDetailResponseToDomain(
        model: BrandUserDetailDTOResponse
    ) -> UserDetailInfo {
        UserDetailInfo(
            systemName: model.info.systemName,
            displayName: model.info.displayName,
            position: model.info.position,
            imageURL: BrandMarketAPIConstants.baseURL + (model.info.imageURL ?? ""),
            permission: model.info.permission
        )
    }
}

final class BrandErrorConverter {
    static func AFErrorToBrandAPIError(error: AFError) -> BrandAPIError {
        switch error {
        case .responseSerializationFailed( _):
            return .serializationError
        default:
            return .unknownError
        }
    }
}
