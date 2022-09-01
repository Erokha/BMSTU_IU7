import Foundation

fileprivate struct SearchScreenMockConstants {
    static let mockData = [
        SearchScreenItemModel(
            brand: "Vans",
            price: 3990,
            itemName: "Off the wall",
            imageURL: URL(
                string: "https://www.traektoria.ru/upload/iblock/4e8/4e838a44dfcdb9c396732699bfd5dcfe.jpg"
            ),
            type: "T-Shirt",
            code: "5e32gwevg774rbe331zasfh",
            avaliable: true
        ),
        SearchScreenItemModel(
            brand: "Puma",
            price: 8900,
            itemName: "RS-2K SOFT METAL",
            imageURL: URL(
                string: "https://images.puma.net/images/374666/01/w/1000/h/1000/fnd/RUS/"
            ),
            type: "Shoe",
            code: "0z5e11dvg234rwe331zasfh",
            avaliable: true
        ),
        SearchScreenItemModel(
            brand: "Puma",
            price: 4995,
            itemName: "RS-X³ PUZZLE",
            imageURL: URL(
                string: "https://sneakers123.s3.amazonaws.com/release/102194/puma-rs-x3-puzzle-371570-04.jpg"
            ),
            type: "Shoe",
            code: "0z5e11dvg234rwe331zasfh",
            avaliable: false
        ),
    ]

}

final class SearchScreenMockInteractor {
    weak var output: SearchScreenInteractorOutput?
    private func updateModel(model: [SearchScreenItemModel]) {
        output?.updateModel(with: model)
    }
}

extension SearchScreenMockInteractor: SearchScreenInteractorInput {
    func searchProducts(searchInfo: String) {
        self.updateModel(model: SearchScreenMockConstants.mockData)
    }
    
}


