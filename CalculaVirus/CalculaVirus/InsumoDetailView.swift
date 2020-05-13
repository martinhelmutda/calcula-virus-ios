//
//  SwiftUIView.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 12/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI

struct InsumoDetailView: View {
    
    var insumo : Insumo
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(insumo.nombre
                )
                    .font(.title)

                HStack(alignment: .top) {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("California")
                        .font(.subheadline)
                }
            }
            .padding()

            Spacer()
        }
    }
}

struct InsumoDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        InsumoDetailView(insumo: insumos[0])
    }
}
