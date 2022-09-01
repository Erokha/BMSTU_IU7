import Foundation

public struct BrandMarketAPIConstants {
    //static let baseURL: String = "http:localhost:8000"
	static let baseURL: String = "http://194.67.110.6:8000"
}

public enum BrandAPIError: Error {
    case serializationError
    case networkUnreachable
    case unknownError
    case noToken
}
