//
//  LaunchView.swift
//  Remedios
//
//  Created by Julio Figueiredo on 13/06/22.
//

import SwiftUI

struct LaunchView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var viewModel: LaunchViewModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 40)
            
            VStack (spacing: 20) {
                Text("Bem-vindo(a) ao")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Remédios")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            
            Spacer()
                .frame(height: 40)
            
            VStack (alignment: .leading) {
                HStack {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.blue)
                    VStack (alignment: .leading) {
                        Text("Notas")
                            .font(.system(size: 18, weight: .bold))
                        Text("Registre os remédios que você precisa tomar.")
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.blue)
                    VStack (alignment: .leading) {
                        Text("Calendario")
                            .font(.system(size: 18, weight: .bold))
                        Text("Defina o período de uso dos remédios.")
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                
                HStack {
                    Image(systemName: "bell.badge.fill")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.blue)
                    VStack (alignment: .leading) {
                        Text("Notificação")
                            .font(.system(size: 18, weight: .bold))
                        Text("Receba notificações na hora que seus remédios devem ser tomados.")
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
            .padding()
            
            Spacer()
            
            Button {
                viewModel.setAppInit()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Começar")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(viewModel: LaunchViewModel(interactor: LaunchInteractor()))
    }
}
