//
//  LugarDetailView.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 01/06/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI

struct LugarDetailView: View {
    var lugar : Lugar
    
    var body: some View {
        VStack {
            CircleImage(image: ImageView(withURL: lugar.image!)).frame(width: 200,height: 200)
            
            VStack(alignment: .leading) {
                
                Text(lugar.nombre)
                    .font(.title)
                
                
            }.padding()
            Section{
                VStack(alignment: .leading){
                    Text(lugar.descripcion ?? "").font(.body)
                }
            }
            
            Spacer()
        }
    }
}

struct LugarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let json = [
            "id": 1,
            "nombre": "El Norte",
            "descripcion": "Lo compré en el norte",
            "image": "http://127.0.0.1:8000/media/lugares/IMG_9887_Uc8cqdb.JPG",
            "user": "a01701813@itesm.mx"
            ] as [String : Any]
        
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let lugar = try! JSONDecoder().decode(Lugar.self, from: data)
        
        return LugarDetailView(lugar: lugar)
    }
}
