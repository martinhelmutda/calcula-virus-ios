//
//  URLImage.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 19/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import Foundation
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
var body: some View {
    VStack {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }.onReceive(imageLoader.dataPublisher) { data in
        self.image = UIImage(data: data) ?? UIImage()
    }
  }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "http://127.0.0.1:8000/media/products/None/images_f4XgBiS.jpeg")
    }
}
