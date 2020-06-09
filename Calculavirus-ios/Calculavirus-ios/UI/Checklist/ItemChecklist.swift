//
//  Checklist.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 06/06/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI
import Foundation


struct ItemChecklist: View {
    var insumo: Insumo
    @State private var prioridad = 0
    
    var body: some View {
        HStack {
            CheckboxFieldView()
            
            VStack(alignment: .leading){
                
                Text(insumo.nombre).bold()
                Text(String(insumo.categoria!))
                    .foregroundColor(Color.gray)
            }
            Spacer()
            VStack{
                Text("Cantidad: \(prioridad)")
                Stepper("Title", value: $prioridad, in: 0...30).labelsHidden()
            }.padding(.trailing,20)
            
        }
    }
}

struct ItemChecklist_Previews: PreviewProvider {
    static var previews: some View {
        
        let json = [
            "id": 1,
            "user":"a01701813@itesm.mx",
            "nombre": "Mezcal el pescador de sueños",
            "marca": "Pescador de sueños",
            "descripcion": "Un Mezcal de los dioses",
            "lugar_compra": "http://127.0.0.1:8000/lugares/1/",
            "categoria": "Elíxir",
            "caducidad": "2022-09-03T00:00:00Z",
            "fecha_ultima_compra": "2022-09-03T00:00:00Z",
            "cantidad": "1",
            "prioridad": 5,
            "duracion_promedio": 1234,
            "image": "http://martinhelmut.pythonanywhere.com/media/market.jpg"
            ] as [String : Any]
        
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let insumo = try! JSONDecoder().decode(Insumo.self, from: data)
        
        return ItemChecklist(insumo:insumo)
    }
}



struct CheckboxFieldView : View {
    
    @State var checkState:Bool = false ;
    
    var body: some View {
        
        Button(action:
            {
                //1. Save state
                self.checkState = !self.checkState
                print("State : \(self.checkState)")
                
                
        }) {
            HStack(alignment: .top, spacing: 10) {
                
                //2. Will update according to state
                Rectangle()
                    .fill(self.checkState ? Color.black : Color(red:230/255,green: 230/255, blue:230/255))
                    .frame(width:20, height:20, alignment: .center)
                    .cornerRadius(5)
                    .padding()
                    .shadow(radius: 2)
                
            }
        }
        .foregroundColor(Color.white)
        
    }
    
}
