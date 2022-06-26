//
//  RemedioRowViewModel.swift
//  Remedios
//
//  Created by Julio Figueiredo on 10/06/22.
//

import Foundation
import Combine

struct RemedioRowViewModel: Identifiable, Equatable {
    var id = ""
    var remedio = ""
    var nome = ""
    var frequencia:Int16 = 0
    var inicio = Date()
    var final = Date()
    var usoContinuo = false
    
    var remedioPublisher: PassthroughSubject<Bool, Never>
    
    static func == (lhs: RemedioRowViewModel, rhs: RemedioRowViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
