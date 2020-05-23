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
                CircleImage(image: ImageView(withURL: insumo.image!)).frame(width: 100,height: 100)
                Text(insumo.nombre)
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
        let json = [
            "id": 1,
            "nombre": "Mezcal el pescador de sueños",
            "marca": "Pescador de sueños",
            "descripcion": "Un Mezcal de los dioses",
            "lugar_compra": "http://127.0.0.1:8000/lugares/1/",
            "categoria": "Elíxir",
            "caducidad": "2022-09-03T00:00:00Z",
            "cantidad": "1",
            "prioridad": 5,
            "duracion_promedio": 1234,
            "image": "http://127.0.0.1:8000/media/products/None/images_f4XgBiS.jpeg"
            ] as [String : Any]

        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let insumo = try! JSONDecoder().decode(Insumo.self, from: data)

        return InsumoDetailView(insumo: insumo)
    }
}
