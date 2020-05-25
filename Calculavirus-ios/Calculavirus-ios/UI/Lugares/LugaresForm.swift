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
    
    func checkDetails(lugar: LugarSend) {

        let urlString = "http://127.0.0.1:8000/lugares/"
        let authToken = "Basic bm9yY286bm9yY29ub3Jjbw=="
        
        let headers = [
            "Authorization": authToken,
            "Content-Type": "multipart/form-data"
        ]
        
        let parameters: [String:Any] = [
            "nombre":lugar.nombre,
            "descripcion":lugar.descripcion
        ]
       
        ImageUploader.uploadPhoto(urlString, image: lugar.image ?? UIImage(), params: parameters, header: headers)
        
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
            Form{
                
                TextField("Nombre", text: $nombre)
                TextField("Descripcion", text: $descripcion)
                
                Section{
                    VStack {
                        Button(action: {
                            self.showCaptureImageView.toggle()
                        }) {
                            Text("Imagen (opcional)")
                        }
                            
                        .sheet(isPresented: $showCaptureImageView) {
                            CaptureImageView(isShown: self.$showCaptureImageView, image: self.$image)
                        }
                        if(image != nil){
                            Image(uiImage: image ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                }
                
                
                Section{
                    Button("Guardar", action: {
                        let dataLugar = LugarSend(nombre: self.nombre, descripcion: self.descripcion, image: self.image ?? UIImage())
                        self.manager.checkDetails(lugar: dataLugar)
                    })
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
