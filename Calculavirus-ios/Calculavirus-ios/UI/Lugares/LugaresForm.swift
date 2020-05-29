//
//  LugaresForm.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 22/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI
import Combine
import Foundation
import Alamofire
import SwiftyJSON


struct LugarSend {
    let nombre : String
    let descripcion : String
    let image : UIImage?
}

class HttpAuth: ObservableObject {
    var didChange = PassthroughSubject<HttpAuth, Never>()
    
    
    var authenticated = false {
        didSet {
            didChange.send(self)
        }
    }
    
    func checkDetails(lugar: LugarSend, parameters: [String:Any]) {
        
        let urlString = "http://127.0.0.1:8000/lugares/"
        let authToken = "Basic bm9yY286bm9yY29ub3Jjbw=="
        
        let headers = [
            "Authorization": authToken,
            "Content-Type": "multipart/form-data"
        ]
        
        if(lugar.image == nil){
            
            NetworkingManager.uploadSomeData(urlString, params: parameters, header: headers)
        }else{
            ImageUploader.uploadPhoto(urlString, image: lugar.image, params: parameters, header: headers)
        }
        
        
    }
}

struct LugaresForm: View {
    
    @State private var nombre = ""
    @State private var descripcion = ""
    @State private var image: UIImage? = nil
    @State private var showCaptureImageView: Bool = false
    
    var manager = HttpAuth()
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
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
                    TextField("Nombre", text: $nombre)
                    TextField("Descripcion", text: $descripcion)
                    
                    
                    
                    
                    Section{
                        Button("Guardar", action: {
                            let dataLugar = LugarSend(nombre: self.nombre, descripcion: self.descripcion, image: self.image)
                            
                            let parameters: [String:Any] = [
                                "nombre":dataLugar.nombre,
                                "descripcion":dataLugar.descripcion
                            ]
                            self.manager.checkDetails(lugar: dataLugar, parameters: parameters)
                        })
                    }
                }
            }
                
            .navigationBarTitle("Registrar Lugar")
        }
    }
}

struct LugaresForm_Previews: PreviewProvider {
    static var previews: some View {
        LugaresForm()
    }
}
