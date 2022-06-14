//
//  AddRemedioUIState.swift
//  Remedios
//
//  Created by Julio Figueiredo on 06/06/22.
//

import Foundation

enum AddRemedioUIState: Equatable {
  case none
  case loading
  case success
  case error(String)
}
