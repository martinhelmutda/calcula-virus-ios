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
    @EnvironmentObject var userData: UserData

    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        VStack{
            
//             Home()
            
            if status {
                 Home()

            }else{
                 LoginView()
            }
        }
        .animation(.spring())
            .onAppear{
                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main){
                    (_) in
//                    Esto está dando problemas

                    let currentStatus = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    self.status = currentStatus

                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
