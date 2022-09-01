import Foundation


final class NewUserScreenPresenter {
	weak var view: NewUserScreenViewInput?

	private let router: NewUserScreenRouterInput
	private let interactor: NewUserScreenInteractorInput


    init(router: NewUserScreenRouterInput, interactor: NewUserScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NewUserScreenPresenter: NewUserScreenViewOutput {
    func didTapRegisterButton(systemName: String, displayName: String, permission: String, position: String) {
        guard let permissionEnumed = BrandPermission(rawValue: permission) else {
            self.handleFail(with: "No such permission")
            return 
        }
    
        let model = BrandUserDetailDTOResponse.UserDetailDTO(
            systemName: systemName,
            displayName: displayName,
            position: position,
            imageURL: nil,
            permission: permissionEnumed
        )
        
        interactor.registerUser(with: model)
    }
    
}

extension NewUserScreenPresenter: NewUserScreenInteractorOutput {
    func handleSuccess(user: BrandUserDTO) {
        router.showUserInfo(user: user)
    }
    
    func handleFail(with text: String) {
        router.showError(with: text)
    }
    
}


