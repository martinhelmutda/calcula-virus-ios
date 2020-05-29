//
//  Home.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 27/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct Home: View {

    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button(action:{
                GIDSignIn.sharedInstance().signOut()
            } ){
                Text("Cerrar sesión")
            }
            
            if(Auth.auth().currentUser?.displayName != nil) {
                Text(String((Auth.auth().currentUser?.displayName)!))
            } else {
                Text("Doesn’t contain a value.")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
