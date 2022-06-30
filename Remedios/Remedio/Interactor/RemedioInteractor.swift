//
//  RemedioInteractor.swift
//  Remedios
//
//  Created by Julio Figueiredo on 06/06/22.
//

import Foundation
import Combine
import CoreData

class RemedioInteractor {
    private let local: LocalDataSource = .shared
}

extension RemedioInteractor {
    func delete(context: NSManagedObjectContext, id: String) {
        local.deleteAgendamento(com: context, id: id)
    }
    
    func deleteNotification(id: String) {
        local.deleteNotication(id: id)
    }
    
    func loadAgendamentos(context: NSManagedObjectContext) -> Future<[Agendamento]?, Never> {
        local.getAgendamentos(com: context)
    }
    
    func checkAppInit() -> Bool {
        return local.checkAppInit()
    }
}

