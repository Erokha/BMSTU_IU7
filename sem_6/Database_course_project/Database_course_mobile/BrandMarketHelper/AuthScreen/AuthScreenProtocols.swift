import Foundation

protocol AuthScreenViewInput: AnyObject {
    func startAwait()
    func stopAwait()
}

protocol AuthScreenViewOutput: AnyObject {
    func didTapSingInButton(username: String, password: String)
}

protocol AuthScreenInteractorInput: AnyObject {
    func logIn(username: String, password: String)
}

protocol AuthScreenInteractorOutput: AnyObject {
    func hadleSuccessLogIn()
    func handleFailLogIn(with error: String)
}

protocol AuthScreenRouterInput: AnyObject {
    func showMainApp()
    func showError(with text: String)
}
