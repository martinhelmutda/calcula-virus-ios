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

//struct LugarSend {
//    let nombre : String
//    let descripcion : String
//    let image : UIImage?
//    let user : String
//}
//
//class HttpAuth: ObservableObject {
//    var didChange = PassthroughSubject<HttpAuth, Never>()
//
//
//    var authenticated = false {
//        didSet {
//            didChange.send(self)
//        }
//    }
//
//    func checkDetails(lugar: LugarSend, parameters: [String:Any]) {
//
//        let urlString = "http://127.0.0.1:8000/lugares/"
//        let authToken = "Basic bm9yY286bm9yY29ub3Jjbw=="
//
//        let headers = [
//            "Authorization": authToken,
//            "Content-Type": "multipart/form-data"
//        ]
//
//        if(lugar.image == nil){
//
//            NetworkingManager.uploadSomeData(urlString, params: parameters, header: headers)
//        }else{
//            ImageUploader.uploadPhoto(urlString, image: lugar.image, params: parameters, header: headers)
//        }
//
//
//    }
//}

struct InsumosFormView: View {
    @ObservedObject var lugaresManager = LugaresManager()
    //    @ObservedObject var form = InsumoCreate()
    
    //    @State private var cantidad : Int
    
    @State private var nombre = ""
      @State private var marca = ""
    @State private var descripcion = ""
    @State private var lugar_compra = 0
    @State private var categoria = ""
    @State private var cantidad = 0
    @State private var caducidad = ""
    @State private var prioridad = 0
    @State private var duracion_promedio = 0
    @State private var user = ""
    @State private var image: UIImage? = nil
    
    
    @State private var showCaptureImageView: Bool = false
    @State private var selectedCategoria = 0
    
    
    var categorias = ["Frutas y Vegetales", "Postres", "Congelados", "Carnes", "Lácteos y Huevo", "Pastas y Harinas", "Pan", "Bebidas", "Procesados", "Higiene", "Limpieza"]
    
    var body: some View {
        VStack{
            Button(action: {
                self.showCaptureImageView.toggle()
            }) {
                if(image == nil){
                    HStack(spacing: 10) {
                        Spacer()
                        Image(systemName: "photo")
                        Text("Agregar Imagen")
                            .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 100)
                        Spacer()
                    }.background(Color.gray.opacity(0.4))
                }
            }
                
            .sheet(isPresented: $showCaptureImageView) {
                CaptureImageView(isShown: self.$showCaptureImageView, image: self.$image)
            }
            if(image != nil){
                Image(uiImage: image ?? UIImage())
                    .resizable()
                    .aspectRatio(0.75,contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200, alignment: .center)
                    .clipped()
            }
        Form{
            Section{
                TextField("Nombre", text: $nombre)
                TextField("Marca", text: $marca)
                TextField("Descripción", text: $descripcion)
            }
            
            Section{
            Picker(selection: $selectedCategoria, label: Text("Categoría")) {
                      ForEach(0 ..< categorias.count) {
                         Text(self.categorias[$0])
                      }
                   }
                   Text("You selected: \(categorias[selectedCategoria])")
            
            Picker(selection: $lugar_compra, label: Text("Lugar de compra")){
                ForEach(lugaresManager.lugares) { lugar in Text(lugar.nombre)
                }
            }
                
            Stepper("Prioridad (0 - 5) \(prioridad)", value: $prioridad, in: 0...5)
                
            Stepper("Días de duración \(duracion_promedio)", value: $duracion_promedio, in: 0...105)
            }
            
            Section{
            Stepper("Ingresa la cantidad \(cantidad)", value: $cantidad, in: 0...20)
            }
            
        }
    }.navigationBarTitle("Registrar Insumos")
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        
        return InsumosFormView()
    }
}
