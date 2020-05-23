//
//  InsumosForm.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 21/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

//class InsumoCreate: ObservableObject {
//
////    Never Sends data
//    var didChange = PassthroughSubject<Void, Never>()
//
//    var lugar_compra = 0
//    var cantidad = 18
//
//    var nombre = ""
//    var descripcion = ""
//    var marca = "" { didSet { update() }}
//    var categoria = "" { didSet { update() }}
//    var caducidad = "" { didSet { update() }}
//    var prioridad = 0 { didSet { update() }}
//    var duracion_promedio = 0 { didSet { update() }}
//    var image = "" { didSet { update() }}
//
//    func update() {
//        didChange.send(())
//    }
//
//}

struct InsumosFormView: View {
    @ObservedObject var lugaresManager = LugaresManager()
//    @ObservedObject var form = InsumoCreate()
    
//    @State private var cantidad : Int
    @State private var lugar_compra = 0
    @State private var cantidad = 0
    @State private var nombre = ""
    @State private var descripcion = ""
    @State private var marca = ""
    @State private var categoria = ""
    @State private var caducidad = ""
    @State private var prioridad = 0
    @State private var duracion_promedio = 0
    @State private var image = ""
    

    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Nombre", text: $nombre)
                    TextField("Marca", text: $marca)
                    TextField("Descripción", text: $descripcion)
                }
                
                Picker(selection: $lugar_compra, label: Text("Lugar de compra")){
                    ForEach(lugaresManager.lugares) { lugar in Text(lugar.nombre)
                    }
                }
//                Stepper("Enter your age \(form.cantidad)", onIncrement: {
//                    self.age += 1
//                    print("Adding to age \(self.form.cantidad)")
//                }, onDecrement: {
//                    self.age -= 1
//                    print("Subtracting from age \(self.form.cantidad)")
//                })
                
                Stepper("Ingresa la cantidad \(cantidad)", value: $cantidad, in: 0...20)
//
//                Text("Cantidad actual: \(form.cantidad)")
//                .onReceive(imageLoader.dataPublisher) { data in
//                    self.image = UIImage(data: data) ?? UIImage()
//                }
                
            }.navigationBarTitle("Registrar Insumos")
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {

        return InsumosFormView()
    }
}
