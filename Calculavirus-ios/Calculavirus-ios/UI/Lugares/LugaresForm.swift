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

struct  ServerMessage : Decodable {
    let status, message : String?
}

struct LugarSend : Codable {
    let nombre : String
    let descripcion : String
//    let image : String
}

class HttpAuth: ObservableObject {
    var didChange = PassthroughSubject<HttpAuth, Never>()
    
    var authenticated = false {
        didSet {
            didChange.send(self)
        }
    }
    
    func checkDetails(nombre: String, descripcion: String, image: UIImage?) {
        let base64String: String
        let dataRaw: LugarSend
        let body:[String : Any]
        
        let urlString = "http://127.0.0.1:8000/lugares/"
        guard let url = URL(string: urlString) else {return}
        
        
        let dataImage = image?.pngData()
        
        if dataImage == nil {
            
//            body = [
//                       "nombre" : nombre,
//                       "descripcion" : descripcion
//                   ]
            dataRaw  = LugarSend(nombre: nombre, descripcion: descripcion)
            
        }else{
             base64String = dataImage!.base64EncodedString(options: .lineLength64Characters)
                
//            body = [
//                "nombre" : nombre,
//                "descripcion" : descripcion,
//                "image" : base64String
//            ]
            
            dataRaw  = LugarSend(nombre: nombre, descripcion: descripcion)
            
        }
        
        print(dataImage)
        
        
        
//        print(body)
        
//        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        guard let uploadData = try? JSONEncoder().encode(dataRaw) else {
            return
        }
        
//        print(dataRaw)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Basic bm9yY286bm9yY29ub3Jjbw==", forHTTPHeaderField: "Authorization")
//        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        URLSession.shared.dataTask(with: request){(data, response, error) in
//
//            guard let data = data else { return }
//
//            let finalData = try! JSONDecoder().decode(ServerMessage.self, from: data)
//
//            print(finalData)
//            print(response)
//            print(error)
//
//        }.resume()
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            print(data)
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
        }
        task.resume()
        
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
                    
                    //                    if (showCaptureImageView) {
                    //                        CaptureImageView(isShown: $showCaptureImageView, image: $image)
                    //                    }
                }
                
                
                Section{
                    Button("Guardar", action: {
                        print(self.nombre)
                        print(self.descripcion)
                        print(self.image)
                        self.manager.checkDetails(nombre: self.nombre, descripcion: self.descripcion, image: self.image ?? UIImage())
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
