import Foundation

protocol NewUserScreenViewInput: AnyObject {
}

protocol NewUserScreenViewOutput: AnyObject {
    func didTapRegisterButton( systemName: String, displayName: String, permission: String, position: String)
}

protocol NewUserScreenInteractorInput: AnyObject {
    func registerUser(with model: BrandUserDetailDTOResponse.UserDetailDTO)
}

protocol NewUserScreenInteractorOutput: AnyObject {
    func handleSuccess(user: BrandUserDTO)
    func handleFail(with text: String)
}

protocol NewUserScreenRouterInput: AnyObject {
    func showUserInfo(user: BrandUserDTO)
    func showError(with text: String)
}
