//
//  InsumosGeneralView.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 12/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI

struct InsumosGeneralView: View {
    @ObservedObject var networkingManager = GetInsumoManager()
    
    public init() {
        //       imageLoader = DataLoader(resourseURL: imageURL)
    }
    
    var body: some View {
        VStack{
            NavigationLink(destination: InsumosFormView()){
               Image(systemName: "plus").shadow(radius: 0.9)
                Text("Agregar Insumo").shadow(radius: 0.9)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30, maxHeight: 35, alignment: .center)
            .background(Color( red: 248/255, green: 39/255, blue: 22/255))
            .foregroundColor(Color.white)
            .font(Font.headline.weight(.medium))
            .cornerRadius(25)
            .shadow(radius: 2)
            .padding(.top)
            .padding(.leading,30)
            .padding(.trailing,30)
            
            List(networkingManager.insumos){ insumo in
                NavigationLink(destination: InsumoDetailView(insumo: insumo)) {
                    InsumoRow(insumo: insumo)
                    //                    URLImage(url: insumo.image)
                }
            }
        }
        .onAppear(perform: networkingManager.fetch)
        .navigationBarTitle("Mis Insumos")
    }
}

struct InsumosGeneralView_Previews: PreviewProvider {
    static var previews: some View {
        InsumosGeneralView()
    }
}
