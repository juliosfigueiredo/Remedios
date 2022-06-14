//
//  RemedioUIState.swift
//  Remedios
//
//  Created by Julio Figueiredo on 06/06/22.
//

import Foundation

enum RemedioUIState: Equatable {
    case loading
    case emptyList
    case non
    case fullList([RemedioRowViewModel])
    case error(String)
}
