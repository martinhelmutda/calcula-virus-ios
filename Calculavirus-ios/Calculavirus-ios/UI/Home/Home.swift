//
//  Home.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 27/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI


struct Home: View {
    
    var body: some View {
        NavigationView {
           VStack {
               NavigationLink(destination: ItemList()) {
                ButtonHome(title: "Checklist", colorBack: Color( red: 16/255, green: 216/255, blue: 184/255))
               }
            
                NavigationLink(destination: InsumosGeneralView()) {
                    ButtonHome(title: "Insumos", colorBack: Color( red: 248/255, green: 39/255, blue: 22/255))
                }
//
                NavigationLink(destination: LugaresListView()) {
                    ButtonHome(title: "Lugares de compra", colorBack: Color( red: 251/255, green: 215/255, blue: 4/255))
                }
            
                Logout()
           }.navigationBarTitle("Calculavirus")
            }

    }
}


struct ButtonHome: View {
    var title: String
    var colorBack: Color
    
    var body: some View {

       Text(title)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 150, alignment: .center)
       .background(colorBack)
//        .color(Color.white)
       .foregroundColor(Color.white)
        .font(Font.title.weight(.heavy))
        .cornerRadius(25)
        .shadow(radius: 10)
        .padding()
            
    }
}


struct ButtonHome_Previews: PreviewProvider {
    static var previews: some View {
        ButtonHome(title: "Insumos", colorBack: Color( red: 16/255, green: 216/255, blue: 184/255))
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
