//
//  EndPoint.swift
//  Coastals
//
//  Created by ZRMacbookPro on 19/09/2023.
//

import Foundation

enum EndPoint: Equatable {
    
    case tasks
    
    var url: String {
        switch self {
        case .tasks:
            return ".mockable.io/"
        }
    }
    
    var method: String {
        switch self {
        case .tasks:
            return "GET"
        }
    }
}

