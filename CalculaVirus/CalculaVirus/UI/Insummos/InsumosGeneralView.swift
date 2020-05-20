//
//  InsumosGeneralView.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 12/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI

struct InsumosGeneralView: View {
    @ObservedObject var networkingManager = NetworkingManager()
//    @ObservedObject private var imageLoader: DataLoader
    
    public init() {

//       imageLoader = DataLoader(resourseURL: imageURL)
   }
    
    var body: some View {
        NavigationView{
            List(networkingManager.insumos){ insumo in
                NavigationLink(destination: InsumoDetailView(insumo: insumo)) {
                    InsumoRow(insumo: insumo)
                }
            }
        .navigationBarTitle("Insumos")
        }
        
    }
}

struct InsumosGeneralView_Previews: PreviewProvider {
    static var previews: some View {
        InsumosGeneralView()
    }
}
