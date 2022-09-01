import Foundation

final class ProfileScreenPresenter {
	weak var view: ProfileScreenViewInput?
    let provider = BrandMarketAuthProvider.shared //MARK: Should be protocol, but i'm too lazy
    
    var model: UserDetailInfo? {
        didSet {
            view?.updateInfo()
        }
    }
    
    var cellViewModels: [ProfileScreenDefaultSectionModel] {
        guard let model = self.model else { return [] }
        var models: [ProfileScreenDefaultSectionModel] = []
        models.append(
            ProfileScreenDefaultSectionModel(
                infoType: "Position",
                title: model.position,
                action: nil,
                style: .defaultCell
                )
        )
        models.append(
            ProfileScreenDefaultSectionModel(
                infoType: "SystemName",
                title: model.systemName,
                action: nil,
                style: .defaultCell
            )
        )
        models.append(
            ProfileScreenDefaultSectionModel(
                infoType: "Permissions",
                title: model.permission.rawValue,
                action: nil,
                style: .defaultCell
            )
        )
        models.append(
            ProfileScreenDefaultSectionModel(
                infoType: nil,
                title: "Log out",
                action: {
                    BrandMarketAuthProvider.shared.logOut()
                },
                style: .buttonCell
            )
        )
        return models
    }

	private let router: ProfileScreenRouterInput
	private let interactor: ProfileScreenInteractorInput

    init(router: ProfileScreenRouterInput, interactor: ProfileScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfileScreenPresenter: ProfileScreenViewOutput {
    func handleImageData(data: Data?) {
        guard let data = data else { return }
        interactor.uploadImage(data: data)
    }
    
    func didLoadView() {
        interactor.updateDeailInfo()
    }
    
}

extension ProfileScreenPresenter: ProfileScreenInteractorOutput {
    func handleSuccessDetailInfo(with model: UserDetailInfo) {
        self.model = model
    }
    
    func handleFailDetailInfo() {
        self.model = nil
        router.showError(with: "Unable to load detail info")
    }
    
    func handleSuccessImageUpload() {
        NotificationCenter.default.post(name: .brandMarketClearImageCache, object: nil)
        interactor.updateDeailInfo()
    }
    
    func handleFailImageUpload() {
        router.showError(with: "Unable to upload new image")
    }
    
}


