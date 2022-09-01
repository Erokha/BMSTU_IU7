import Foundation

public struct StockProductDTOModel: Codable {
    public let size: String
    public let amount: Int
    public let model: ProductDTOModel
}


public struct ProductDTOModel: Codable {
    public let code: String
    public let name: String
    public let price: Int
    private let image: String?
    public let type: ProductType
    public var sizes: [ProductDTOStockSize]?
    public let brand: String
    public var imageURL: URL? {
        guard let imagePath = self.image else { return nil }
        return URL(string: BrandMarketAPIConstants.baseURL + imagePath)
    }
    
    public struct ProductDTOStockSize: Codable {
        public let size: String
        public let amount: Int
    }
    
    public enum ProductType: String, Codable {
        case hat = "Hat"
        case tshirt = "T-shirt"
        case pants = "Pants"
        case shoes = "Shoes"
    }
}

public struct DTOProvidedSizes: Codable {
    public let sizes: [String]
    
    public enum CodingKeys : String, CodingKey {
        case sizes = "provided_sizes"
    }
}
