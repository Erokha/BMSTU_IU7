import Alamofire
import Foundation

public typealias BrandToken = String

public class BrandMarketAuthProvider {
    public static var shared: BrandMarketAuthProvider = BrandMarketAuthProvider()
    
    private init() { }
    
    func validateUser(
        model: BrandUserDTO,
        completion: @escaping ((Result<BrandToken, BrandAPIError>) -> Void)
    ) {
        let url = "\(BrandMarketAPIConstants.baseURL)/shop/auth"
        let parameters: [String: String] = [
            "type": "validate",
            "password": model.password,
            "username": model.username
        ]
        let request = AF.request(
            url,
            method: .post,
            parameters: parameters
        )
        request.responseDecodable(of: BrandUserValidateResponse.self) { response in
            switch response.result {
            case .success(let reponseModel):
                switch reponseModel.status {
                case "ok":
                    self.saveUserToUserDefaults(username: model.username, password: model.password)
                    self.updateToken(token: reponseModel.token)
                    completion(.success(reponseModel.token))
                default:
                    completion(.failure(.unknownError))
                }
            case .failure(let error):
                completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
            }
        }
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: BrandUserDefaultsKeys.usernameKey)
        UserDefaults.standard.removeObject(forKey: BrandUserDefaultsKeys.passwordKey)
        UserDefaults.standard.removeObject(forKey: BrandUserDefaultsKeys.tokenKey)
        NotificationCenter.default.post(
            name: .brandMarketLogOut,
            object: nil
        )
    }
    
    func checkSuccessValidateFromUserDefault(
        completion: @escaping ((Bool) -> Void)
    ){
        guard let username = UserDefaults.standard.string(forKey: BrandUserDefaultsKeys.usernameKey),
              let password = UserDefaults.standard.string(forKey: BrandUserDefaultsKeys.passwordKey)
        else {
            completion(false)
            return
        }
        let model = BrandUserDTO(
            username: username,
            password: password
        )
        validateUser(model: model) { [weak self] response in
            guard let self = self else {
                completion(false)
                return
            }
            switch response {
            case .success(let model):
                self.updateToken(token: model)
                completion(true)
            case .failure( _):
                completion(false)
            }
        }
    }
    
    func updateImage(
        imageData: Data?,
        completion: @escaping ((Result<Bool, BrandAPIError>) -> Void)
    ) {
        guard let token = self.getToken() else {
            completion(.failure(.noToken))
            return
        }
        let url = "\(BrandMarketAPIConstants.baseURL)/shop/auth"
        let parameters: [String: String] = [
            "type": "update_image",
            "username": token
        ]
        _ = AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let valueData = value.data(using: String.Encoding.utf8) {
                    multipartFormData.append(valueData, withName: key)
                    
                }
                
            }
            if let data = imageData {
                multipartFormData.append(data, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
            }
            
        },
        to: url).responseDecodable(of: UpdateImageResponse.self) { response in
            switch response.result {
            case .success(let result):
                if result.status == "ok" {
                    completion(.success(true))
                } else {
                    completion(.failure(.serializationError))
                }
            case .failure(let error):
                completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
            }
        }
    }
    
    func getDetailInfo(
        with token: BrandToken,
        completion: @escaping ((Result<UserDetailInfo, BrandAPIError>) -> Void)
    ) {
        let url = "\(BrandMarketAPIConstants.baseURL)/shop/auth"
        let parameters: [String: String] = [
            "type": "detail_info",
            "username": token
        ]
        let request = AF.request(
            url,
            method: .post,
            parameters: parameters
        )
        request.responseDecodable(of: BrandUserDetailDTOResponse.self) { response in
            switch response.result {
            case .success(let reponseModel):
                switch reponseModel.status {
                case "ok":
                    let domain = BrandAPIConverter.convertDTOBrandUserDetailResponseToDomain(
                        model: reponseModel
                    )
                    completion(.success(domain))
                default:
                    completion(.failure(.unknownError))
                }
            case .failure(let error):
                completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
            }
        }
    }
    
    func registerNewUser(
        newUserInfo: BrandUserDetailDTOResponse.UserDetailDTO,
        completion: @escaping ((Result<BrandUserDTO, BrandAPIError>) -> Void)
    ) {
        guard let token = self.getToken() else {
            completion(.failure(.noToken))
            return
        }
        let url = "\(BrandMarketAPIConstants.baseURL)/shop/auth"
        let parameters: [String: String] = [
            "type": "register_user",
            "owner_login": token,
            "system_name": newUserInfo.systemName,
            "displayed_name": newUserInfo.displayName,
            "permission": newUserInfo.permission.rawValue,
            "position": newUserInfo.position
        ]
        let request = AF.request(
            url,
            method: .post,
            parameters: parameters
        )
        request.responseDecodable(of: RegistrationResponseDTO.self) { response in
            switch response.result {
            case .success(let reponseModel):
                switch reponseModel.status {
                case "ok":
                    completion(.success(reponseModel.result))
                default:
                    completion(.failure(.unknownError))
                }
            case .failure(let error):
                completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
            }
        }
    }
    
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: BrandUserDefaultsKeys.tokenKey)
    }
    
}

public struct BrandUserDefaultsKeys {
	static let usernameKey = "Brand.username"
	static let passwordKey = "Brand.password"
	static let tokenKey = "Brand.token"
}

public extension BrandMarketAuthProvider {
    private func saveUserToUserDefaults(
        username: String,
        password: String
    ) {
        UserDefaults.standard.setValue(username, forKey: BrandUserDefaultsKeys.usernameKey)
        UserDefaults.standard.setValue(password, forKey: BrandUserDefaultsKeys.passwordKey)
    }
    
    private func updateToken(token: BrandToken) {
        UserDefaults.standard.setValue(token, forKey: BrandUserDefaultsKeys.tokenKey)
    }
}
