//
//  LugaresManager.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 21/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import FirebaseAuth

class LugaresManager: ObservableObject {
    
    var didChange = PassthroughSubject<LugaresManager, Never>()
    
    @Published var lugares = [Lugar]()
    
    init() {
        fetch()
    }
    
    
    func fetch()  {
         let user = String(describing: Auth.auth().currentUser!.email!)
        
        let urlString = "http://martinhelmut.pythonanywhere.com/lugares/get_lugares_by_user/?user_email=" + user
        
        
        guard let url = URL(string: urlString) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //        request.addValue("Basic Y2FsY3VsYXZpcnVzOmFkbWlu", forHTTPHeaderField: "Authorization")
        request.addValue("Basic bm9yY286bm9yY29ub3Jjbw==", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            do{
                if let lugaresData = data{
                    
                    let lugaresResultData = try JSONDecoder().decode(LugaresResult.self, from: lugaresData)
                    
                    //                    print(lugaresResultData)
                    DispatchQueue.main.async {
                        self.lugares = lugaresResultData.results
                    }
                } else {
                    print("No Data")
                }
            } catch {
                print("ErrorLugar")
            }
        }.resume()
    }
}




//http://martinhelmut.pythonanywhere.com/lugares/

//struct LugaresManager_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
