import Alamofire
import Foundation

public class BrandMarketAPIProvider {
    public static var shared: BrandMarketAPIProvider = BrandMarketAPIProvider()
    
    private init() { }
    
    private func filterDataByAmount(_ data:[ProductDTOModel]) -> [ProductDTOModel] {
        var newData = data
        for i in 0..<newData.count {
            newData[i].sizes = newData[i].sizes?.filter { $0.amount > 0 }
        }
        return newData
    }
    
    func searchInDatabase(searchInfo: String, completion: @escaping (Result<[SearchScreenItemModel], BrandAPIError>) -> Void) {
        let request = AF.request("\(BrandMarketAPIConstants.baseURL)/shop/products?search=\(searchInfo)")
        request.responseDecodable(of: [ProductDTOModel].self) { response in
                switch response.result {
                case .success(let data):
                    let filteredData = self.filterDataByAmount(data)
                    completion(.success(filteredData.map { BrandAPIConverter.convertProductModelToSearchScreenItemModel(model: $0) }))
                case .failure(let error):
                    completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
                }
            }
    }
    
    func getModel(code: String, completion: @escaping (Result<DetailScreenModel, BrandAPIError>) -> Void) {
        let request = AF.request(
            "\(BrandMarketAPIConstants.baseURL)/shop/products?code=\(code)",
            method: .get
        )
        request.responseDecodable(of: ProductDTOModel.self) { response in
            switch response.result {
            case .success(let data):
                let model = BrandAPIConverter.converProductModelToDetailScreenModel(model: data)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
            }
        }
    }
    
    func getProvdedSizes(of code: String, completion: @escaping (Result<ProvidedSizes, BrandAPIError>) -> Void) {
        let url = "\(BrandMarketAPIConstants.baseURL)/shop/products?provided_sizes=\(code)"
        let request = AF.request(
            url,
            method: .get
        )
        request.responseDecodable(of: DTOProvidedSizes.self) { response in
            switch response.result {
            case .success(let data):
                let model = BrandAPIConverter.convertDTOProvidedSizesToDomain(model: data)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
            }
        }
    }
    
    func sendNewSupply(with supplyModel: SupplyDTOModel, completion: @escaping (Result<SupplyResponseDTOModel, BrandAPIError>) -> Void) {
        let url = "\(BrandMarketAPIConstants.baseURL)/shop/supply"
        let parameters: [String: String] = [
            "type": "supply_item",
            "code": supplyModel.code,
            "amount": supplyModel.amount,
            "size": supplyModel.size]
        let request = AF.request(
            url,
            method: .post,
            parameters: parameters
        )
        request.responseDecodable(of: SupplyResponseDTOModel.self) { response in
            switch response.result {
            case .success(let model):
                switch model.status {
                case "ok":
                    completion(.success(model))
                default:
                    completion(.failure(.unknownError))
                }
            case .failure(let error):
                completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
            }
        }
    }
    
    func sellItem(with supplyModel: SupplyDTOModel, completion: @escaping (Result<SupplyResponseDTOModel, BrandAPIError>) -> Void) {
        let url = "\(BrandMarketAPIConstants.baseURL)/shop/supply"
        let parameters: [String: String] = [
            "type": "sell_item",
            "code": supplyModel.code,
            "amount": supplyModel.amount,
            "size": supplyModel.size]
        let request = AF.request(
            url,
            method: .post,
            parameters: parameters
        )
        
        request.responseDecodable(of: SupplyResponseDTOModel.self) { response in
            switch response.result {
            case .success(let model):
                switch model.status {
                case "ok":
                    completion(.success(model))
                default:
                    completion(.failure(.unknownError))
                }
            case .failure(let error):
                completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
            }
        }
    }
	
	func sellMultiplyItems(
		with models: [SupplyDTOModel],
		customerServiceInfo : CustumerSerivceDTOItem,
		completion: @escaping (Result<SupplyResponseDTOModel, BrandAPIError>) -> Void
	) {
		let url = "\(BrandMarketAPIConstants.baseURL)/shop/supply"
		let parameters: [String: String] = [
			"type": "sell_multiply_items",
			"code": models.map { $0.code }.joined(separator: ","),
			"amount": models.map { $0.amount }.joined(separator: ","),
			"size": models.map { $0.size }.joined(separator: ","),
			"assistant_name": customerServiceInfo.assistantName,
			"client_name": customerServiceInfo.clientName,
			"client_email": customerServiceInfo.clientEmail,
		]
		let request = AF.request(
			url,
			method: .post,
			parameters: parameters
		)
		
		request.responseDecodable(of: SupplyResponseDTOModel.self) { response in
			switch response.result {
			case .success(let model):
				switch model.status {
				case "ok":
					completion(.success(model))
				default:
					completion(.failure(.unknownError))
				}
			case .failure(let error):
				completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
			}
		}
	}
	
	func reserve(with supplyModel: SupplyDTOModel, completion: @escaping (Result<SupplyResponseDTOModel, BrandAPIError>) -> Void) {
		let url = "\(BrandMarketAPIConstants.baseURL)/shop/supply"
		let parameters: [String: String] = [
			"type": "reserve_item",
			"code": supplyModel.code,
			"amount": supplyModel.amount,
			"size": supplyModel.size]
		let request = AF.request(
			url,
			method: .post,
			parameters: parameters
		)
		
		request.responseDecodable(of: SupplyResponseDTOModel.self) { response in
			switch response.result {
			case .success(let model):
				switch model.status {
				case "ok":
					completion(.success(model))
				default:
					completion(.failure(.unknownError))
				}
			case .failure(let error):
				completion(.failure(BrandErrorConverter.AFErrorToBrandAPIError(error: error)))
			}
		}
	}
    
}
