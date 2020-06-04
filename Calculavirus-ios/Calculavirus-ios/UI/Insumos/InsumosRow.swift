//
//  InsumoRow.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 19/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import Foundation
import SwiftUI

struct InsumoRow: View {
    var insumo: Insumo

    var body: some View {
        HStack {
            ImageView(withURL: insumo.image!)
                .frame(width: 50,height: 50)
                .clipped()
                .cornerRadius(5)
                .padding(5)
            VStack(alignment: .leading){
                Text(insumo.nombre).bold()
                Text("Faltan " + String(insumo.duracion_promedio) + " día(s)")
                    .foregroundColor(Color.gray)
            }
            Spacer()
            Text("Cantidad: " + String(insumo.cantidad))
                .padding(.trailing, 20)
        }
    }
}

struct InsumoRow_Previews: PreviewProvider {
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

        return InsumoRow(insumo: insumo)
    }
}
