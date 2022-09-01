import Foundation

final class AuthScreenPresenter {
	weak var view: AuthScreenViewInput?

	private let router: AuthScreenRouterInput
	private let interactor: AuthScreenInteractorInput

    init(router: AuthScreenRouterInput, interactor: AuthScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AuthScreenPresenter: AuthScreenViewOutput {
    func didTapSingInButton(username: String, password: String) {
        interactor.logIn(username: username, password: password)
        view?.startAwait()
    }
    
}

extension AuthScreenPresenter: AuthScreenInteractorOutput {
    func hadleSuccessLogIn() {
        view?.stopAwait()
        router.showMainApp()
    }
    
    func handleFailLogIn(with error: String) {
        view?.stopAwait()
        router.showError(with: error)
    }
}


