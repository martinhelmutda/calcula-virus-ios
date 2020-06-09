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
import FirebaseAuth


struct InsumoSend {
    var nombre: String
    var marca: String?
    var descripcion: String?
    var lugar_compra: String
    var categoria: String?
    var caducidad: String
    var cantidad: String
    var prioridad: Int
    var duracion_promedio: Int
    var image:UIImage?
    var user:String
}


class sendHTTPInsumo: ObservableObject {
    var didChange = PassthroughSubject<sendHTTPInsumo, Never>()
    
    var authenticated = false {
        didSet {
            didChange.send(self)
        }
    }
    
    func checkDetails(insumo: InsumoSend, parameters: [String:Any]) {
        
        let urlString = "http://martinhelmut.pythonanywhere.com/insumos/"
        let authToken = "Basic bm9yY286bm9yY29ub3Jjbw=="
        
        let headers = [
            "Authorization": authToken,
            "Content-Type": "multipart/form-data"
        ]
        
        if(insumo.image == nil){
            NetworkingManager.uploadSomeData(urlString, params: parameters, header: headers)
        }else{
            ImageUploader.uploadPhoto(urlString, image: insumo.image, params: parameters, header: headers)
        }
        
        
    }
}

struct InsumosFormView: View {
    
    @ObservedObject var lugaresManager = LugaresManager()
    @ObservedObject var networkingManager = GetInsumoManager()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    //    @ObservedObject var form = InsumoCreate()
    
    //    @State private var cantidad : Int
    
    @State private var nombre = ""
    @State private var marca = ""
    @State private var descripcion = ""
    @State private var lugar_compra = 0
    @State private var categoria = ""
    @State private var cantidad = 0
    @State private var caducidad = Date()
    @State private var prioridad = 0
    @State private var duracion_promedio = 0
    @State private var user = ""
    @State private var image: UIImage? = nil
    
    
    @State private var showCaptureImageView: Bool = false
    @State private var selectedCategoria = 0
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var categorias = ["Frutas y Vegetales", "Postres", "Congelados", "Carnes", "Lácteos y Huevo", "Pastas y Harinas", "Pan", "Bebidas", "Procesados", "Higiene", "Limpieza", "Otros"]
    
    var manager = sendHTTPInsumo()
   
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
                            .frame(
                                minWidth: 0,
                                maxWidth: 200,
                                minHeight: 0,
                                maxHeight: 100)
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
                    
                    Picker(selection: $lugar_compra, label: Text("Lugar de compra")){
                        ForEach(lugaresManager.lugares) { lugar in Text(lugar.nombre)
                        }
                    }
                    
                    
                    Stepper("Prioridad (0 - 5) \(prioridad)", value: $prioridad, in: 0...5)
                    
                    DatePicker(selection: $caducidad, in: Date()..., displayedComponents: .date) {
                        Text("Fecha de caducidad")
                    }
                    Stepper("Días de duración \(duracion_promedio)", value: $duracion_promedio, in: 0...105)
                }
                
                Section{
                    Stepper("Ingresa la cantidad \(cantidad)", value: $cantidad, in: 0...20)
                }
                
                Button("Guardar", action: {
                    let user = Auth.auth().currentUser!.displayName
                    
                    let urlStringLugares = "http://martinhelmut.pythonanywhere.com/lugares/"
                    
                    let df = DateFormatter()
                    df.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    let caducidadInsumo = df.string(from: self.caducidad)
                    
                    let dataInsumo = InsumoSend(
                        nombre: self.nombre,
                        marca: self.marca,
                        descripcion: self.descripcion,
                        lugar_compra: (urlStringLugares + String(self.lugar_compra)+"/"),
                        categoria: self.categorias[self.selectedCategoria],
                        caducidad: caducidadInsumo,
                        cantidad: String(self.cantidad),
                        prioridad: self.prioridad,
                        duracion_promedio: self.duracion_promedio,
                        image: self.image,
                        user: user!)
                    
                    let parameters: [String:Any] = [
                        "nombre":dataInsumo.nombre,
                        "marca":dataInsumo.marca ?? "",
                        "descripcion":dataInsumo.descripcion ?? "",
                        "lugar_compra": dataInsumo.lugar_compra,
                        "categoria": dataInsumo.categoria ?? "",
                        "caducidad": dataInsumo.caducidad,
                        "cantidad": dataInsumo.cantidad,
                        "prioridad": dataInsumo.prioridad,
                        "duracion_promedio": dataInsumo.duracion_promedio,
                        "user": dataInsumo.user
                    ]
                    
                    self.manager.checkDetails(insumo: dataInsumo, parameters: parameters)
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.networkingManager.fetch()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    
                    
                    
                })
            }
        }.navigationBarTitle("Registrar Insumos")
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        
        return InsumosFormView()
    }
}

