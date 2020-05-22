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

class InsumoCreate: ObservableObject {
    
//    Never Sends data
    var didChange = PassthroughSubject<Void, Never>()
    
    var lugar_compra = 0 { didSet { update() }}
    var cantidad: Int = 0 { didSet { update() }}
    
    var nombre = "" { didSet { update() }}
    var descripcion = "" { didSet { update() }}
    var marca = "" { didSet { update() }}
    var categoria = "" { didSet { update() }}
    var caducidad = "" { didSet { update() }}
    var prioridad = 0 { didSet { update() }}
    var duracion_promedio = 0 { didSet { update() }}
    var image = "" { didSet { update() }}

    func update() {
        didChange.send(())
    }

}

struct FormView: View {
    @ObservedObject var lugaresManager = LugaresManager()
    @ObservedObject var form = InsumoCreate()
//    @State private var enableLogging = false
//
//    @State private var selectedColor = 0
//    @State private var colors = ["Red", "Green", "Blue"]

    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Nombre", text: $form.nombre)
                    TextField("Marca", text: $form.marca)
                    TextField("Descripción", text: $form.descripcion)
                }
                
                Picker(selection: $form.lugar_compra, label: Text("Lugar de compra")){
                    ForEach(lugaresManager.lugares) { lugar in Text(lugar.nombre)
                    }
                }
                Stepper(value: $form.cantidad, in: 1...10){
                        Text("Cantidad actual: \(form.cantidad)")
                }
                
            }.navigationBarTitle("Registrar Insumos")
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {

        return FormView()
    }
}
