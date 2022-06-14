//
//  LaunchInteractor.swift
//  Remedios
//
//  Created by Julio Figueiredo on 14/06/22.
//

import Foundation
import Combine
import CoreData

class LaunchInteractor {
    private let local: LocalDataSource = .shared
}

extension LaunchInteractor {
    
    func setAppInit() {
        local.setAppInit()
    }
    
    func checkAppInit() -> Bool {
        return local.checkAppInit()
    }
}
