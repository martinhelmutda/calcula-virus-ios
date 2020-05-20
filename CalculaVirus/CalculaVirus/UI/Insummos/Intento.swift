//
//  Intento.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 19/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//


import SwiftUI

struct ContentView : View {
    
    let url = "http://127.0.0.1:8000/media/products/None/images_f4XgBiS.jpeg"
    
    var body: some View {
        
        URLImage(url: url)
        
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
       
        return ContentView()
    }
}
