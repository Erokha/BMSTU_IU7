import Foundation

public extension Notification.Name {
    static let brandMarketClearImageCache = Notification.Name("BrandMarket.ClearImageCache")
    static let brandMarketUpdateDetailScreen = Notification.Name("BrandMarket.UpdateDetailScreen")
    static let brandMarketLogInSuccess = Notification.Name("BrandMarket.LogInSuccess")
    static let brandMarketLogOut = Notification.Name("BrandMarket.LogOut")
	static let brandMarketTraitCollectionDidChange = Notification.Name("BrandMarket.TraitCollectionDidChange")
}

public extension Formatter {
	static let withSeparator: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.groupingSeparator = " "
		return formatter
	}()
}

public extension Numeric {
	var brandMoneyStyle: String { Formatter.withSeparator.string(for: self) ?? "" }
}
