//
//  NetworkingManager.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 12/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import Foundation

import SwiftUI
import Combine

class NetworkingManager: ObservableObject {
    
    var didChange = PassthroughSubject<NetworkingManager, Never>()
    
    @Published var insumos = [Insumo]()

    
    init() {
//        let urlString = "http://martinhelmut.pythonanywhere.com/insumos/"
        let urlString = "http://127.0.0.1:8000/insumos/"
        
        guard let url = URL(string: urlString) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
//        request.addValue("Basic Y2FsY3VsYXZpcnVzOmFkbWlu", forHTTPHeaderField: "Authorization")
        request.addValue("Basic bm9yY286bm9yY29ub3Jjbw==", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            do{
                if let insumosData = data{
                    let insumosResultData = try JSONDecoder().decode(InsumosResult.self, from: insumosData)
                    
                    DispatchQueue.main.async {
                        self.insumos = insumosResultData.results
                    }
                } else {
                    print("No Data")
                }
            } catch {
                print("Error")
            }
        }.resume()
    }
}
