import Foundation

final class SupplyScreenInteractor {
	weak var output: SupplyScreenInteractorOutput?
    let provider = BrandMarketAuthProvider.shared //MARK: Should be protocol, but i'm too lazy
}

extension SupplyScreenInteractor: SupplyScreenInteractorInput {
    func checkPermissionAccess() {
        guard let token = provider.getToken() else {
            return
        }
        provider.getDetailInfo(
            with: token
        ) { [weak self] response in
            switch response {
            case .success(let info):
                self?.output?.handlePermissionAccess(acessLevel: info.permission)
            case .failure( _):
                return
            }
        }
    }
    
}
