import Foundation

//MARK: DTOUser and Registration
public struct BrandUserDTO: Codable {
    let username: String
    let password: String
}

public struct RegistrationResponseDTO: Codable {
    let status: String
    let result: BrandUserDTO
}

//MARK: UserDetail
public struct BrandUserDetailDTOResponse: Codable {
    let status: String
    let info: UserDetailDTO
    
    struct UserDetailDTO: Codable {
        let systemName: String
        let displayName: String
        let position: String
        let imageURL: String?
        let permission: BrandPermission
        
        public enum CodingKeys: String, CodingKey {
            case systemName = "system_name"
            case displayName = "displayed_name"
            case position
            case imageURL = "image"
            case permission
        }
    }
}

//MARK: Validate
public struct BrandUserValidateResponse: Codable {
    let status: String
    let token: BrandToken
}

//MARK: ImageResponse
public struct UpdateImageResponse: Codable {
    let status: String
    let type: String?
}
