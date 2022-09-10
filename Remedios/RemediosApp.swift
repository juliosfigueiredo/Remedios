//
//  RemediosApp.swift
//  Remedios
//
//  Created by Julio Figueiredo on 04/06/22.
//

import SwiftUI
import UserNotifications
import NotificationCenter

@main
struct RemediosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) private var scenePhase
    var viewModel: RemedioViewModel
    
    init() {
        viewModel = RemedioViewModel(interactor: RemedioInteractor(), context: persistenceController.container.viewContext)
        let appInit = viewModel.checkAppInit()
        if appInit {
            viewModel.appInit = false
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            RemedioView()
                .environmentObject(viewModel)
        }
        .onChange(of: scenePhase) { phase in
                    
                    switch phase {
                        
                    case .background:
                        print("Meu app está em background")
                    case .inactive:
                        print("Meu app está em inativo")
                    case .active:
                        viewModel.getRemedios()
                        autorizarNotificar()
                        getDataInstalacaoDoApp()
                    @unknown default:
                        print("Meu app está em estado indefinido")
                        
                    }
                }
    }
    
    private func getDataInstalacaoDoApp() {
        if
            let urlToDocumentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last,
            let installDateAny = (try? FileManager.default.attributesOfItem(atPath: urlToDocumentsFolder.path)[.creationDate]),
            let installDate = installDateAny as? Date
        {
            print("This app was installed by the user on \(installDate)")
        }
    }
    
    private func autorizarNotificar() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "remediosCategory.stopNotificationAction":
            removeNotification(id: response.notification.request.identifier)
        case "remediosCategory.cancelarAction": break
            // Handle action
        default:
            break
        }
        completionHandler()
    }
    
    private func removeNotification(id: String) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Show local notification in foreground
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
}
