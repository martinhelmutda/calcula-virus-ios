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

class HttpAuth: ObservableObject {
    var didChange = PassthroughSubject<HttpAuth, Never>()
    
    var authenticated = false {
        didSet {
            didChange.send(self)
        }
    }
    
    func checkDetails(nombre: String, descripcion: String) {
        let urlString = "http://127.0.0.1:8000/lugares/"
        guard let url = URL(string: urlString) else {return}
        
        let body: [String : String] = [
            "nombre" : nombre,
            "descripcion" : descripcion
        ]
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Basic bm9yY286bm9yY29ub3Jjbw==", forHTTPHeaderField: "Authorization")
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){(data, response, error) in
            
            guard let data = data else { return }
            
            let finalData = try! JSONDecoder().decode(ServerMessage.self, from: data)
            
            print(finalData)
            
        }.resume()
        
    }
}

struct LugaresForm: View {
    
    @State private var nombre = ""
    @State private var descripcion = ""
    
    var manager = HttpAuth()
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Nombre", text: $nombre)
                TextField("Descripcion", text: $descripcion)
                
                Section{
                    Button("Guardar", action: {
                       print(self.nombre)
                       print(self.descripcion)
                        self.manager.checkDetails(nombre: self.nombre, descripcion: self.descripcion)
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
