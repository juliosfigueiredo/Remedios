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
    @Published var titulo = ""
    @Published var subtitulo = ""
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
    
    func addRemedio() {
        let model = AddRemedioModel(id: UUID().uuidString,
                                    paciente: self.paciente,
                                    remedio: self.remedio,
                                    frequencia: self.getFrequencia(),
                                    comeca: self.comeca,
                                    termina: self.termina,
                                    usoContinuo: self.usoContinuo)
        
        interactor.add(context: context!, model: model)
        self.remedioPublisher?.send(true)
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
        }
    }
    
    func addNotificacao() {
        let content = UNMutableNotificationContent()
        content.title = "Teste"
        content.subtitle = "Testando notificaçãp"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        /*
        var date = DateComponents()
        date.hour = 00
        date.minute = 18
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)*/
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 60, repeats: true)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: "teste", content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    func add() {
        let content = UNMutableNotificationContent()
        content.interruptionLevel = .timeSensitive
        content.body = "Teste"
        content.subtitle = "Testando notificaçãp"
        content.categoryIdentifier = "Task Actions" // Same Identifier in registerCategories()
        content.sound = UNNotificationSound.default
        let taskIdentifier = "rerererererer"
                            
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        let request = UNNotificationRequest(identifier: taskIdentifier, content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        
                    
        let markAsCompleted = UNNotificationAction(identifier: "MARK_AS_COMPLETED", title: "Mark as Completed", options: .foreground)
                    
        let placeholder = "Task"
        let category = UNNotificationCategory(identifier: "Task Actions", actions: [markAsCompleted], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: placeholder) // // Same Identifier in schedulNotification()
                    
        center.setNotificationCategories([category])
                    
        center.add(request)
    }
    
    func removeNotification() {
        
        var array:[String] = []
        
        array.append("teste")
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: array)
        center.removeDeliveredNotifications(withIdentifiers: array)
    }

}

