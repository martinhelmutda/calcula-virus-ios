//
//  URLImage.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 19/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import Foundation
import SwiftUI

struct URLImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    
    var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        self.imageLoader.load(url: url)
    }
    
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage).resizable()
        } else {
            return placeholder
        }
        
//        let uiImage = self.imageLoader.downloadedImage!
//            return Image(uiImage: uiImage).resizable()
//
//
    }
    
}
