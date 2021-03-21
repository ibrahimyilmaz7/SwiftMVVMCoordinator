//
//  String+Extensions.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Foundation

extension String {
    
    /// Simplified string localization method
    /// - Parameter comment: parameter to pass NSLocalizedString
    /// - Returns: String value of NSLocalizedString(_, comment:)
    func localized(comment: String = "") -> String {
        NSLocalizedString(self, comment: comment)
    }
}
