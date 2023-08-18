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
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 5) {
                Label("Remédio", systemImage: "pills")
                    .accessibilityLabel("Remédio")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .labelStyle(.titleAndIcon)
                Text(viewModel.remedio)
                    .font(.headline)
            }
            Spacer()
                .frame(height: 3)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Label("Usuário", systemImage: "person")
                        .accessibilityLabel("Usuário")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .labelStyle(.titleAndIcon)
                    Text(viewModel.nome)
                        .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Label("Frequência", systemImage: "clock")
                        .accessibilityLabel("Frequência")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .labelStyle(.titleAndIcon)
                    Text(viewModel.frequencia == 24 ? "1 vez ao dia" : "\(viewModel.frequencia) em \(viewModel.frequencia) horas")
                        .font(.subheadline)
                }
            }
            Spacer()
                .frame(height: 3)
            VStack(alignment: .leading, spacing: 5) {
                Label("Período", systemImage: "calendar")
                    .accessibilityLabel("8 em 8 horas")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .labelStyle(.titleAndIcon)
                Text(viewModel.usoContinuo ? "Uso contínuo" : "De \(viewModel.inicio.formatted()) à \(viewModel.final.formatted())")
                    .font(.subheadline)
            }
        }
        .opacity(viewModel.ativo ? 1 : 0.3)
    }
}
/*
struct RemedioRowView_Previews: PreviewProvider {
    static var previews: some View {
        RemedioRowView()
            .previewLayout(.fixed(width: 400, height: 100))
            .previewDevice("iPhone 11")
    }
}
 */
