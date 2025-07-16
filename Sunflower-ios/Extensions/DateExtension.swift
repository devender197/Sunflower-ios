//
//  DateExtension.swift
//  GithubProfiler
//
//  Created by Devender Singh on 5/7/25.
//

import Foundation

extension Date {
    
    func toStringFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMdd, yyyy"
        return formatter.string(from : self)
    }
}
