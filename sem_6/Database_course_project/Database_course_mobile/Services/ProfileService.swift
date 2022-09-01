//
//  ProfileService.swift
//  BrandMarketHelper
//
//  Created by kymblc on 01.10.2021.
//

import Foundation

final class ProfileProvider {
	public static let instance = ProfileProvider()
	private let authProvider = BrandMarketAuthProvider.shared
	
	private init() {}
	
	var unsafeTradingUserSystemName: String {
		UserDefaults.standard.string(forKey: BrandUserDefaultsKeys.usernameKey) ?? "mobileAssistant"
	}
}
