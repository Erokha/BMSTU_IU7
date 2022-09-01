import Foundation

protocol ProfileScreenViewInput: AnyObject {
    func updateInfo()
}

protocol ProfileScreenViewOutput: AnyObject {
    var model: UserDetailInfo? { get }
    var cellViewModels: [ProfileScreenDefaultSectionModel] { get }
    func didLoadView()
    func handleImageData(data: Data?)
}

protocol ProfileScreenInteractorInput: AnyObject {
    func uploadImage(data: Data)
    func updateDeailInfo()
}

protocol ProfileScreenInteractorOutput: AnyObject {
    func handleSuccessDetailInfo(with model: UserDetailInfo)
    func handleFailDetailInfo()
    func handleSuccessImageUpload()
    func handleFailImageUpload()

}

protocol ProfileScreenRouterInput: AnyObject {
    func showError(with text: String)
}
