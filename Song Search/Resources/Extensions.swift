//
//  Extensions.swift
//  Song Search
//
//  Created by prabhanjan on 08/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func getCurrencySymbol() -> String? {
        let locale = NSLocale(localeIdentifier: self)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: self)
    }
}
