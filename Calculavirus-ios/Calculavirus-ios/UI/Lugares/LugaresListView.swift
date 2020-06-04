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
        VStack{
            NavigationLink(destination: LugaresForm()){
                 Image(systemName: "plus").shadow(radius: 0.9)

                Text("Agregar Lugar").shadow(radius: 0.9)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30, maxHeight: 35, alignment: .center)
                .background(Color( red: 251/255, green: 215/255, blue: 4/255))
                .foregroundColor(Color.white)
                .font(Font.headline.weight(.medium))
                .cornerRadius(25)
                .shadow(radius: 2)
                .padding(.top)
                .padding(.leading,30)
                .padding(.trailing,30)
            
            
            List(lugarManager.lugares){ lugar in
                NavigationLink(destination: LugarDetailView(lugar: lugar)) {
                    LugarRow(lugar: lugar)
                }
            }
        }
        .onAppear(perform: lugarManager.fetch)
        .navigationBarTitle("Lugares")
        //        .navigationBarItems(trailing:
        //
        //        )
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
                .cornerRadius(5)
                .padding(5)
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
            "image": "http://127.0.0.1:8000/media/lugares/file_5tPPfks.jpg",
            "user": "a01701813@itesm.mx"
            ] as [String : Any]
        
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let lugar = try! JSONDecoder().decode(Lugar.self, from: data)
        
        return LugarRow(lugar: lugar)
    }
}
