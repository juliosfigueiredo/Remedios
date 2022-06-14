//
//  AddRemedioModel.swift
//  Remedios
//
//  Created by Julio Figueiredo on 08/06/22.
//

import Foundation

struct AddRemedioModel {
    let id:String
    let paciente:String
    let remedio: String
    let frequencia:Int16
    let comeca: Date
    let termina: Date
    let usoContinuo: Bool
}
