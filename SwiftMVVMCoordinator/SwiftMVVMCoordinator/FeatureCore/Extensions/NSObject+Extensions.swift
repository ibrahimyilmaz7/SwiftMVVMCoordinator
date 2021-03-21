//
//  NSObject+Extensions.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import UIKit

extension NSObject {
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    
    static var className: String {
        return String(describing: Self.self)
    }
}
