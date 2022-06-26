//
//  RemedioRowView.swift
//  Remedios
//
//  Created by Julio Figueiredo on 04/06/22.
//

import SwiftUI

struct RemedioRowView: View {
    let viewModel: RemedioRowViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "pills.fill")
                .font(.system(size: 35, weight: .regular))
                //.foregroundStyle(.blue)
                .symbolRenderingMode(.multicolor)
            VStack (alignment: .leading, spacing: 15) {
                Text(viewModel.remedio)
                    .font(.headline)
                HStack {
                    Text(viewModel.nome)
                        .font(.subheadline)
                    Spacer()
                    Text(viewModel.frequencia == 24 ? "1 vez ao dia" : "\(viewModel.frequencia) em \(viewModel.frequencia) horas")
                        .font(.subheadline)
                }
                Text(viewModel.usoContinuo ? "Uso contínuo" : "\(viewModel.inicio.formatted()) à \(viewModel.final.formatted())")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}
/*
struct RemedioRowView_Previews: PreviewProvider {
    static var previews: some View {
        RemedioRowView(viewModel: RemedioRowViewModel(remedioPublisher: PassthroughSubject<Bool, Never>()))
    }
}
 */
