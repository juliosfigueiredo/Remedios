//
//  RemedioView.swift
//  Remedios
//
//  Created by Julio Figueiredo on 10/06/22.
//

import SwiftUI

struct RemedioView: View {
    @EnvironmentObject var viewModel: RemedioViewModel
    @State var isShowView: Bool = false
    //@State var isShowBoasVindas: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                if case RemedioUIState.fullList(let rows) = viewModel.uiState {
                    List {
                        ForEach(rows, id: \.id) { row in
                            RemedioRowView(viewModel: row)
                        }
                        .onDelete { index in
                            let item = rows[index.first!]
                            viewModel.deleteRemedio(id: item.id)
                            viewModel.getRemedios()
                        }
                    }
                } else if case RemedioUIState.loading = viewModel.uiState {
                    ProgressView()
                } else if case RemedioUIState.emptyList = viewModel.uiState {
                    Text("Você ainda não cadastrou remédios")
                } else if case RemedioUIState.error(let error) = viewModel.uiState {
                    Text("")
                      .alert(isPresented: .constant(true)) {
                        Alert(
                          title: Text("Ops! \(error)"),
                          message: Text("Tentar novamente?"),
                          primaryButton: .default(Text("Sim")) {
                            // aqui executa a retentativa
                              viewModel.getRemedios()
                          },
                          secondaryButton: .cancel()
                        )
                      }
                }
            }
            .navigationBarTitle("Meus remédios")
            .toolbar {
                ToolbarItem(id: "logout", placement: ToolbarItemPlacement.navigationBarTrailing, showsByDefault: true) {
                    Button {
                        isShowView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .padding(6)
                            .frame(width: 30, height: 30)
                            .background(Color.black)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    .fullScreenCover(isPresented: $isShowView) {
                        viewModel.addRemedioView()
                    }
                }
            }
        }
        .onAppear{
            viewModel.getRemedios()
        }
        .sheet(isPresented: $viewModel.appInit) {
            viewModel.launchView()
        }
    }
}

struct RemedioView_Previews: PreviewProvider {
    static var previews: some View {
        RemedioView(isShowView: true)
    }
}
