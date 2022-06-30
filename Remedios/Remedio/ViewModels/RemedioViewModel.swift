//
//  RemedioViewModel.swift
//  Remedios
//
//  Created by Julio Figueiredo on 08/06/22.
//

import Foundation
import Combine
import CoreData
import SwiftUI

class RemedioViewModel:ObservableObject {
    @Published var uiState: RemedioUIState = .loading
    @Published var appInit: Bool = true
    private var cancellableRequest: AnyCancellable?
    private var cancellableNotify: AnyCancellable?
    let interactor: RemedioInteractor
    var context:NSManagedObjectContext? = nil
    
    private let remedioPublisher = PassthroughSubject<Bool, Never>()
    
    init(interactor: RemedioInteractor, context: NSManagedObjectContext) {
        self.interactor = interactor
        self.context = context
        cancellableNotify = remedioPublisher.sink(receiveValue: { saved in
            print("saved: \(saved)")
            self.getRemedios()
        })
    }
    
    deinit {
        cancellableRequest?.cancel()
        cancellableNotify?.cancel()
    }
    
    func checkAppInit() -> Bool {
        return interactor.checkAppInit()
    }
    
    func deleteRemedio(id: String) {
        interactor.delete(context: context!, id: id)
    }
    
    func getRemedios() {
        self.uiState = .loading
        cancellableRequest = interactor.loadAgendamentos(context: context!)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { agendamentos in
                guard let lista = agendamentos else {return}
                if !lista.isEmpty {
                    self.uiState = .fullList(
                        lista.map {
                            let model = RemedioRowViewModel(id: $0.id!,
                                                            remedio: $0.remedio!,
                                                            nome: $0.paciente!,
                                                            frequencia: $0.frequencia,
                                                            inicio: $0.comeca!,
                                                            final: $0.termina!,
                                                            usoContinuo: $0.usoContinuo,
                                                            ativo: self.getInativos(id: $0.id!, termina: $0.termina!, usoContinuo: $0.usoContinuo),
                                                            remedioPublisher: self.remedioPublisher)
                            
                            return model
                        }
                    )
                } else {
                    self.uiState = .emptyList
                }
            })
    }
    
    private func getInativos(id: String, termina: Date, usoContinuo: Bool) -> Bool {
        if !usoContinuo {
            let ativo = Date() < termina
            
            if !ativo {
                interactor.deleteNotification(id: id)
            }
            return ativo
        }
        return true
    }
}

extension RemedioViewModel {
    func addRemedioView() -> some View {
        return RemedioViewRouter.makeAddRemedioView(remedioPublisher: remedioPublisher, context: context!)
    }
    
    func launchView() -> some View {
        return RemedioViewRouter.makeLaunchView()
    }
}
