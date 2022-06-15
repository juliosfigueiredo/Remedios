//
//  AddRemedioView.swift
//  Remedios
//
//  Created by Julio Figueiredo on 04/06/22.
//

import SwiftUI

struct FrequenciaModel: Identifiable, Hashable {
    var id: Int16
    let descricao: String
}

enum Frequencia: String, CaseIterable, Identifiable {
    case umDia = "Uma vez ao dia"
    case dozeHoras = "12 em 12 horas"
    case dezHoras = "10 em 10 horas"
    case oitoHoras = "8 em 8 horas"
    case seisHoras = "6 em 6 horas"
    var id: Self { self }
}

struct AddRemedioView: View {
    
    @ObservedObject var viewModel: AddRemedioViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var dateClosedRange: ClosedRange<Date> {
        let today = Calendar.current.date(byAdding: .minute, value: -1, to: Date())!
        let seven = Calendar.current.date(byAdding: .day, value: 90, to: Date())!
        return today...seven
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nome do usuario", text: $viewModel.paciente)
                TextField("Nome do remédio", text: $viewModel.remedio)
                
                Picker("Frequência de uso", selection: $viewModel.selectedFrequencia) {
                    ForEach(Frequencia.allCases) { frequencia in
                        Text(frequencia.rawValue.capitalized)
                    }
                }
                Toggle("Uso continuo", isOn: $viewModel.usoContinuo)
                DatePicker(selection: $viewModel.comeca, in: dateClosedRange) {
                    Text("Começa")
                }
                .datePickerStyle(CompactDatePickerStyle())
                .disabled(viewModel.usoContinuo == true)
                DatePicker(selection: $viewModel.termina, in: dateClosedRange) {
                    Text("Termina")
                }
                .datePickerStyle(CompactDatePickerStyle())
                .disabled(viewModel.usoContinuo == true)
            }
            .navigationBarTitle("Adicionar remédio")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(id: "close", placement: ToolbarItemPlacement.navigationBarLeading, showsByDefault: true) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                    }
                }
                ToolbarItem(id: "close", placement: ToolbarItemPlacement.navigationBarTrailing, showsByDefault: true) {
                    Button {
                        viewModel.addRemedio()
                        dismiss()
                    } label: {
                        Text("Adicionar")
                    }
                    .disabled(viewModel.remedio.isEmpty)
                    .disabled(viewModel.paciente.isEmpty)
                }
            }
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
/*
struct AddRemedioView_Previews: PreviewProvider {
    @State static var isShowing = true
    static var previews: some View {
        AddRemedioView(viewModel: AddRemedioViewModel(interactor: AddRemedioInteractor()))
    }
}
*/
