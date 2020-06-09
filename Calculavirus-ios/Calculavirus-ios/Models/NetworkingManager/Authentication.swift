//
//  Authentication.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 04/06/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct userSend {
    var nombre: String
    var email:String
}

class sendHttpUser: ObservableObject {
    var didChange = PassthroughSubject<sendHttpUser, Never>()
    
    var authenticated = false {
        didSet {
            didChange.send(self)
        }
    }
    
    func checkDetails(parameters: [String:Any]) {
        
        let urlString = "http://martinhelmut.pythonanywhere.com/users/"
        let authToken = "Basic bm9yY286bm9yY29ub3Jjbw=="
        
        let headers = [
            "Authorization": authToken,
            "Content-Type": "multipart/form-data"
        ]
        
        NetworkingManager.uploadSomeData(urlString, params: parameters, header: headers)
         
    }
}
