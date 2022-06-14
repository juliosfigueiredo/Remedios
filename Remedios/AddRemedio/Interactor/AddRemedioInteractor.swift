//
//  AddRemedioInteractor.swift
//  Remedios
//
//  Created by Julio Figueiredo on 06/06/22.
//

import Foundation
import CoreData

class AddRemedioInteractor {
    private let local: LocalDataSource = .shared
}

extension AddRemedioInteractor {
    func add(context: NSManagedObjectContext, model: AddRemedioModel) {
        local.addAgendamento(com: context, model: model)
    }
}
