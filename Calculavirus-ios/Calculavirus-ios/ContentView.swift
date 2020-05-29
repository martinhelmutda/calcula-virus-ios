//
//  ContentView.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 22/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct ContentView: View {
    
    var body: some View {
        Group{
            
            if Auth.auth().currentUser != nil {
                 Home()

            }else{
                 LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
