//
//  LocalDataSource.swift
//  Remedios
//
//  Created by Julio Figueiredo on 06/06/22.
//

import Foundation
import Combine
import CoreData
import UserNotifications
import NotificationCenter

class LocalDataSource {
  
    static var shared: LocalDataSource = LocalDataSource()
    var agendamentos:[Agendamento] = []
  
    private init() {}
    
    private func saveAppInit() {
        UserDefaults.standard.set(true, forKey: "app_init")
    }
    
    private func getAppInit() -> Bool {
        let appInit = UserDefaults.standard.bool(forKey: "app_init")
        
        return appInit
    }
  
    private func saveValue(context: NSManagedObjectContext, model: AddRemedioModel) {
        let agendamento = Agendamento(context: context)
        agendamento.id = model.id
        agendamento.paciente = model.paciente
        agendamento.remedio = model.remedio
        agendamento.frequencia = model.frequencia
        agendamento.comeca = model.comeca
        agendamento.termina = model.termina
        agendamento.usoContinuo = model.usoContinuo
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func removeAgendamento(idAgendamento: String, context: NSManagedObjectContext) {
        agendamentos = readAgendamentos(com: context)
        if let agendamento = agendamentos.first(where: {$0.id == idAgendamento}) {
            context.delete(agendamento)
            do{
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func removeNotification(id: String) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }

    
    private func readAgendamentos(com context: NSManagedObjectContext) -> [Agendamento] {
        let fetchRequest: NSFetchRequest<Agendamento> = Agendamento.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "comeca", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritor]
        
        do{
            agendamentos = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return agendamentos
    }
}

extension LocalDataSource {
    
    func getAgendamentos(com context: NSManagedObjectContext) -> Future<[Agendamento]?, Never> {
        let agendamentos = readAgendamentos(com: context)
        return Future { promise in
            promise(.success(agendamentos))
        }
    }
    
    func addAgendamento(com context: NSManagedObjectContext, model: AddRemedioModel) {
        saveValue(context: context, model: model)
    }
    
    func deleteAgendamento(com context: NSManagedObjectContext, id: String) {
        removeAgendamento(idAgendamento: id, context: context)
        deleteNotication(id: id)
    }
    
    func deleteNotication(id: String) {
        removeNotification(id: id)
    }
    
    func setAppInit() {
        saveAppInit()
    }
    
    func checkAppInit() -> Bool {
        return getAppInit()
    }
}

