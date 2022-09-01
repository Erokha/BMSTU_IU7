import Foundation

final class AuthScreenInteractor {
	weak var output: AuthScreenInteractorOutput?
    let provider = BrandMarketAuthProvider.shared //MARK: Should be protocol, but i'm too lazy
}

extension AuthScreenInteractor: AuthScreenInteractorInput {
    func logIn(username: String, password: String) {
        let model = BrandUserDTO(
            username: username,
            password: password
        )
        provider.validateUser(model: model) { [weak self] response in
            switch response {
            case .success( _):
                self?.output?.hadleSuccessLogIn()
            case .failure(let error):
                self?.output?.handleFailLogIn(with: error.localizedDescription)
            }
        }
    }
}
