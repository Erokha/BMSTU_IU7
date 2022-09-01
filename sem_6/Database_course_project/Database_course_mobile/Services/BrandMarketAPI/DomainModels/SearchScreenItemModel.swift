import Foundation

public struct SearchScreenItemModel {
    public let brand: String
    public let price: Int
    public let itemName: String
    public let imageURL: URL?
    public let type: String
    public let code: String
    public let avaliable: Bool
}

public struct ProvidedSizes {
    public let sizes: [String]
}
