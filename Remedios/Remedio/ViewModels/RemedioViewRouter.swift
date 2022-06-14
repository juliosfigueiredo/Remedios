//
//  RemedioViewRouter.swift
//  Remedios
//
//  Created by Julio Figueiredo on 10/06/22.
//

import Foundation
import Combine
import SwiftUI
import CoreData

enum RemedioViewRouter {
    static func makeAddRemedioView(remedioPublisher: PassthroughSubject<Bool, Never>, context: NSManagedObjectContext) -> some View {
        let viewModel = AddRemedioViewModel(interactor: AddRemedioInteractor(), context: context)
        viewModel.remedioPublisher = remedioPublisher
        return AddRemedioView(viewModel: viewModel)
    }
    
    static func makeLaunchView() -> some View {
        let viewModel = LaunchViewModel(interactor: LaunchInteractor())
        return LaunchView(viewModel: viewModel)
    }
}
