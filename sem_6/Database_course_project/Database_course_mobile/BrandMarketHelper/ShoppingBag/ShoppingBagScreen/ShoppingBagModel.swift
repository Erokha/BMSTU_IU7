import Foundation

struct ShoppingBagCellModel: Equatable {
	let imageURL: URL?
	let name: String
	let code: String
	let size: String
	var count: Int
	let price: Int
	
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.size == rhs.size && lhs.code == rhs.code
	}
}
