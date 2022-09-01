//
//  BrandColor.swift
//  BrandMarketHelper
//
//  Created by kymblc on 25.07.2021.
//

import Foundation
import UIKit

public struct BrandColors {
	static var mainBackgroundColor: UIColor {
		switch UITraitCollection.current.userInterfaceStyle {
		case .dark:
			return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
		default:
			return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
		}
		
	}
}
