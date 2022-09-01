import Foundation

struct DetailScreenStockSize {
    let size: String
    let amount: Int
	let inShoppingBag: Int?
}

struct DetailScreenModel {
    public let code: String
    public let name: String
    public let price: Int
    public let type: String
    public var sizes: [DetailScreenStockSize]
    public let brand: String
    public let imageURL: String?
}
