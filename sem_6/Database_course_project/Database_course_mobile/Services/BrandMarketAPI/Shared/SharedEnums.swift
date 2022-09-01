public enum BrandPermission: String, Codable {
    case assistant = "Assistant"
    case manager = "Manager"
    case shopOwner = "Shop owner"
}

extension BrandPermission: CaseIterable {}

extension BrandPermission {
    var accessLevel: Int {
        switch self {
        case .assistant:
            return 1
        case .manager:
            return 2
        case .shopOwner:
            return 3
        }
    }
}
