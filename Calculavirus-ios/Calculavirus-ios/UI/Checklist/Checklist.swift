//
//  ItemList.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 06/06/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import SwiftUI

struct ItemList: View {
    @ObservedObject var networkingManager = GetInsumoManager()
    @Environment(\.presentationMode) var presentationMode
    
    public init() {
        //       imageLoader = DataLoader(resourseURL: imageURL)
    }
    
    var body: some View {
        VStack{
            List(networkingManager.insumos){ insumo in
                    ItemChecklist(insumo: insumo)
                    //                    URLImage(url: insumo.image)
             
            }
            Button("Terminado", action: {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        .onAppear(perform: networkingManager.fetch)
        .navigationBarTitle("Checklist")
    }
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemList()
    }
}

