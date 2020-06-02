//
//  LugaresListView.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 31/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI

struct LugaresListView: View {
    @ObservedObject var lugarManager = LugaresManager()
    
    var body: some View {
        List(lugarManager.lugares){ lugar in
            NavigationLink(destination: LugarDetailView(lugar: lugar)) {
                LugarRow(lugar: lugar)
            }
        }
        .onAppear(perform: lugarManager.fetch)
        .navigationBarTitle("Lugares")
        .navigationBarItems(trailing:
            NavigationLink(destination: LugaresForm()){
                Text("Agregar")
            }
        )
    }
}

struct LugaresListView_Previews: PreviewProvider {
    static var previews: some View {
        LugaresListView()
    }
}


struct LugarRow: View {
    var lugar: Lugar
    
    var body: some View {
        HStack {
            ImageView(withURL: lugar.image!)
                .frame(width: 50,height: 50)
                .clipped()
            Text(lugar.nombre)
            Spacer()
        }
    }
}

struct LugarRow_Previews: PreviewProvider {
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
        
        return LugarRow(lugar: lugar)
    }
}
