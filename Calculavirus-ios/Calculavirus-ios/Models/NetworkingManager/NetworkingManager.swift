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
import Alamofire
import SwiftyJSON
import FirebaseAuth

class NetworkingManager {
    static func uploadSomeData(_ url: String, params: [String : Any], header: [String:String]) {
           let httpHeaders = HTTPHeaders(header)
           AF.upload(multipartFormData: { multiPart in
               for p in params {
                   multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
               }
           }, to: url, method: .post, headers: httpHeaders) .uploadProgress(queue: .main, closure: { progress in
               print("Upload Progress: \(progress.fractionCompleted)")
           }).responseString(completionHandler: { data in
               print("upload finished: \(data)")
           }).response { (response) in
               switch response.result {
               case .success(let result):
                   print("upload success result: \(String(describing: result))")
               case .failure(let err):
                   print("upload err: \(err)")
               }
           }
       }
}

class GetInsumoManager: ObservableObject {
    
    var didChange = PassthroughSubject<GetInsumoManager, Never>()
    
    @Published var insumos = [Insumo]()

    
    init() {
        let userEmail = Auth.auth().currentUser?.email
//        let urlString = "http://martinhelmut.pythonanywhere.com/insumos/"
//        let urlString = "http://127.0.0.1:8000/insumos/get_insumos_by_user/??user_email==\(String(describing: userEmail))"
        let urlString = "http://127.0.0.1:8000/insumos/get_insumos_by_user/?user_email=a01701813@itesm.mx"
        
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
