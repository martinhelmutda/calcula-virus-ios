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
    var categorias = ["Frutas y Vegetales", "Postres", "Congelados", "Carnes", "Lácteos y Huevo", "Pastas y Harinas", "Pan", "Bebidas", "Procesados", "Higiene", "Limpieza", "Otros"]
    
    var body: some View {
        VStack() {
            CircleImage(image: ImageView(withURL: insumo.image!)).frame(width: 200,height: 200)
            
            VStack{
                Text(insumo.nombre)
                    .font(.title)
                Text(insumo.marca!)
            }.padding()
            
            VStack(alignment: .leading){
                Text("Descripción")
                    .fontWeight(.bold)
                HStack{
                    Text(insumo.descripcion ?? "")
                    Spacer()
                }.padding(.bottom)
                Text("Categoría")
                    .fontWeight(.bold)
                HStack{
                    Text(String(insumo.categoria ?? "No definida"))
                }.padding(.bottom)
                
                Text("Fecha de caducidad próxima")
                    .fontWeight(.bold)
                HStack{
                    Text(String(insumo.caducidad ?? "No definida"))
                }.padding(.bottom)
                Text("Cantidad existente")
                    .fontWeight(.bold)
                HStack{
                    Text(String(insumo.cantidad))
                }.padding(.bottom)
            }.padding(30)
            Spacer()
        }
    }
}

struct InsumoDetailView_Previews: PreviewProvider {
    
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
            "image": "http://127.0.0.1:8000/media/products/None/images_f4XgBiS.jpeg"
            ] as [String : Any]
        
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let insumo = try! JSONDecoder().decode(Insumo.self, from: data)
        
        return InsumoDetailView(insumo: insumo)
    }
}
