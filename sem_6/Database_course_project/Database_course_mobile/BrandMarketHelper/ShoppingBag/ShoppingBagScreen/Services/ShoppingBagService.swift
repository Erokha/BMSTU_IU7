import Foundation


final class ShoppingBagService {
	struct ModelConverter {
		func ShoppingBagCellModelTo(shoppingBagCellModel: ShoppingBagCellModel) {
			
		}
	}
	static let instance = ShoppingBagService()
	private let lock = NSLock()
	
	private init() {}
	
	private var _items: [ShoppingBagCellModel] = []
	var items: [ShoppingBagCellModel] {
		_items
	}
	
	func add(item: ShoppingBagCellModel) {
		lock.lock()
		guard let i = _items.firstIndex(of: item)
		else {
			_items.append(item)
			lock.unlock()
			return
		}
		_items[i].count += item.count
		lock.unlock()
	}
	
	func remove(item: ShoppingBagCellModel) {
		lock.lock()
		guard let i = _items.firstIndex(of: item)
		else {
			_items.append(item)
			lock.unlock()
			return
		}
		_items[i].count -= item.count
		if _items[i].count <= 0 {
			_items.remove(at: i)
		}
		lock.unlock()
	}
	
	public func removePosition(item: ShoppingBagCellModel, completion: @escaping (([ShoppingBagCellModel]) -> Void)) {
		lock.lock()
		
		_items.removeAll { $0 == item }

		lock.unlock()
		completion(_items)
	}
	
	func handle_success_supply() {
		_items = []
	}
	
	func getItemsByCode(code: String) -> [ShoppingBagCellModel] {
		items.filter { $0.code == code }
	}
}
