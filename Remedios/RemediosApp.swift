//
//  RemediosApp.swift
//  Remedios
//
//  Created by Julio Figueiredo on 04/06/22.
//

import SwiftUI

@main
struct RemediosApp: App {
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
                        autorizarNotificar()
                    @unknown default:
                        print("Meu app está em estado indefinido")
                        
                    }
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
