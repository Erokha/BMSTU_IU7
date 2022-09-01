import Foundation

final class NewUserScreenInteractor {
	weak var output: NewUserScreenInteractorOutput?
    let provider = BrandMarketAuthProvider.shared //MARK: protocol, bla-bla-bla
}

extension NewUserScreenInteractor: NewUserScreenInteractorInput {
    func registerUser(with model: BrandUserDetailDTOResponse.UserDetailDTO) {
        provider.registerNewUser(newUserInfo: model) { [weak self] response in
            switch response {
            case .success(let user):
                self?.output?.handleSuccess(user: user)
            case .failure(let error):
                self?.output?.handleFail(with: error.localizedDescription)
            }
        }
    }
    
}
