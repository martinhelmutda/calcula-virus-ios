//
//  Logout.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 30/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct Logout: View {
    
    var body: some View {
        
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action:{
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    print("All good")
                    //                    self.userData.loggedIn = false
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
            } ){
                Text("Cerrar sesión")
            }
            
//            if(Auth.auth().currentUser?.displayName != nil) {
//                Text(String((Auth.auth().currentUser?.displayName)!))
//            } else {
//                Text("Doesn’t contain a value.")
//            }
        }
    }
}

struct Logout_Previews: PreviewProvider {
    static var previews: some View {
        Logout()
    }
}
