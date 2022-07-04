//
//  AddRemedioViewModel.swift
//  Remedios
//
//  Created by Julio Figueiredo on 04/06/22.
//

import Foundation
import UserNotifications
import NotificationCenter
import CoreData
import Combine

class AddRemedioViewModel: ObservableObject {
    @Published var paciente = String()
    @Published var remedio = String()
    @Published var comeca = Date()
    @Published var termina = Date()
    @Published var usoContinuo: Bool = false
    @Published var disabled: Bool = false
    @Published var frequencias:[FrequenciaModel] = []
    @Published var selectedFrequencia: Frequencia = .umDia
    
    let interactor: AddRemedioInteractor
    
    var remedioPublisher: PassthroughSubject<Bool, Never>?
    var context:NSManagedObjectContext?
    
    init(interactor: AddRemedioInteractor, context: NSManagedObjectContext) {
        self.interactor = interactor
        self.context = context
    }
    
    var dateClosedRange: ClosedRange<Date> {
        let today = Calendar.current.date(byAdding: .minute, value: -1, to: Date())!
        let seven = Calendar.current.date(byAdding: .day, value: 90, to: Date())!
        return today...seven
    }
    
    func addRemedio() {
        let id = UUID().uuidString
        let model = AddRemedioModel(id: id,
                                    paciente: self.paciente,
                                    remedio: self.remedio,
                                    frequencia: self.getFrequencia(),
                                    comeca: self.comeca,
                                    termina: self.termina,
                                    usoContinuo: self.usoContinuo)
        
        interactor.add(context: context!, model: model)
        self.remedioPublisher?.send(true)
        self.addNotification(id: id)
    }
    
    func getFrequencia() -> Int16 {
        switch self.selectedFrequencia {
        case .umDia:
            return 24
        case .dezHoras:
            return 10
        case .dozeHoras:
            return 12
        case .oitoHoras:
            return 8
        case .seisHoras:
            return 6
        case .tresHoras:
            return 3
        case .umaHora:
            return 1
        }
    }
    
    func addNotification(id: String) {
        let stopNotificationAction = UNNotificationAction(identifier: "remediosCategory.stopNotificationAction", title: "Parar notificação", options: [])
        let cancelarAction = UNNotificationAction(identifier: "remediosCategory.cancelarAction", title: "Cancelar", options: [])

        let remediosCategory = UNNotificationCategory(
            identifier: "remediosCategory",
            actions: [stopNotificationAction, cancelarAction],
            intentIdentifiers: [],
            options: .customDismissAction)
        let frequencia = Int(getFrequencia())
        let time:TimeInterval = TimeInterval(frequencia * 60 * 60)
        let content = UNMutableNotificationContent()
        content.title = "Remédios"
        content.body = "\(paciente)! está na hora de tomar \(remedio)"
        content.sound = .default
        content.categoryIdentifier = "remediosCategory"

        UNUserNotificationCenter.current().setNotificationCategories([remediosCategory])
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: time, repeats: true)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}

