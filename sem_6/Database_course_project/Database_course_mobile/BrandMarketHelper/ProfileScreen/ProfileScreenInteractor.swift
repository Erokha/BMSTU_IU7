import Foundation

final class ProfileScreenInteractor {
	weak var output: ProfileScreenInteractorOutput?
    let provider = BrandMarketAuthProvider.shared //MARK: protocol, bla-bla-bla
}

extension ProfileScreenInteractor: ProfileScreenInteractorInput {
    func uploadImage(data: Data) {
        provider.updateImage(imageData: data) { [weak self] response in
            switch response {
            case .success( _):
                self?.output?.handleSuccessImageUpload()
            case .failure(let error):
                self?.output?.handleFailImageUpload()
            }
        }
    }
    func updateDeailInfo() {
        guard let token = provider.getToken() else { return }
        provider.getDetailInfo(with: token) { [weak self] response in
            switch response {
            case .success(let model):
                self?.output?.handleSuccessDetailInfo(with: model)
            case .failure( _):
                self?.output?.handleFailDetailInfo()
            }
        }
    }
    
}
