//
//  LaunchViewModel.swift
//  Remedios
//
//  Created by Julio Figueiredo on 14/06/22.
//

import Foundation

class LaunchViewModel: ObservableObject {
    @Published var appInit: Bool = true
    
    let interactor: LaunchInteractor
    
    init(interactor: LaunchInteractor) {
        self.interactor = interactor
        appInit = checkAppInit()
    }
    
    func checkAppInit() -> Bool {
        return interactor.checkAppInit()
    }
    
    func setAppInit() {
        interactor.setAppInit()
    }
}

extension LaunchViewModel {
    
}
