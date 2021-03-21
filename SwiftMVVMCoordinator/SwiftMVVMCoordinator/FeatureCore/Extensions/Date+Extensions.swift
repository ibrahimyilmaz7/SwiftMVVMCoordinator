//
//  Date+Extensions.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Foundation

extension Date {
    enum ApiFormats: String {
        case `default` = "yyyy-MM-dd"
    }
    
    enum DisplayFormats: String {
        case `default` = "dd.MM.yyyy"
    }
    
    enum TimeZoneIdentifiers: String {
        case `default` = "CET"
    }
}

extension TimeInterval {
    func formatted(
        format: String = Date.DisplayFormats.default.rawValue,
        timeZoneIdentifier: String = Date.TimeZoneIdentifiers.default.rawValue
    ) -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
        
        return dateFormatter.string(from: date)
    }
}
