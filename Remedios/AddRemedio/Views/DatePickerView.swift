//
//  DatePickerView.swift
//  Remedios
//
//  Created by Julio Figueiredo on 03/07/22.
//

import SwiftUI

struct DatePickerView: View {
    @EnvironmentObject var viewModel: AddRemedioViewModel
    
    var body: some View {
        VStack {
            DatePicker(selection: $viewModel.comeca, in: viewModel.dateClosedRange) {
                Text("Começa")
            }
            .datePickerStyle(CompactDatePickerStyle())
            .disabled(viewModel.usoContinuo == true)
            DatePicker(selection: $viewModel.termina, in: viewModel.dateClosedRange) {
                Text("Termina")
            }
            .datePickerStyle(CompactDatePickerStyle())
            .disabled(viewModel.usoContinuo == true)
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
