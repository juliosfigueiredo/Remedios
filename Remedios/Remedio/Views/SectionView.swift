//
//  SectionView.swift
//  Remedios
//
//  Created by Julio Figueiredo on 03/07/22.
//

import SwiftUI

struct SectionView: View {
    @EnvironmentObject var viewModel: RemedioViewModel
    let rows: [RemedioRowViewModel]
    let titulo:String
    let ativo:Bool
    var body: some View {
        Section(header: Text(titulo)) {
            ForEach(rows, id: \.id) { row in
                if row.ativo == ativo {
                    RemedioRowView(viewModel: row)
                }
            }
            .onDelete { index in
                let item = rows[index.first!]
                viewModel.deleteRemedio(id: item.id)
                viewModel.getRemedios()
            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        SectionView(rows: [RemedioRowViewModel](), titulo: "Ativos", ativo: true)
    }
}
