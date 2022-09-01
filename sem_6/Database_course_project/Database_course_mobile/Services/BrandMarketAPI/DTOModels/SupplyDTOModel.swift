import Foundation

public struct SupplyDTOModel {
    public let code: String
    public let size: String
    public let amount: String
}

public struct SupplyResponseDTOModel: Codable {
    let status: String
    let type: String?
}
