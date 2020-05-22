//
//  Prueba.swift
//  Calculavirus-ios
//
//  Created by Martin Helmut Dominguez Alvarez on 22/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

//import SwiftUI
//import Combine
//
//struct PruebaView : View {
//    @ObservedObject var networkingManager = NetworkingManager()
//
//    var body: some View {
//        List(networkingManager.insumos) { post in
//            ImageRow(model: post) // Get image
//        }
//    }
//}
//
///********************************************************************/
//// Download Image
//
//struct ImageRow: View {
//    let model: Insumo
//    var body: some View {
//        VStack(alignment: .center) {
//            ImageViewContainer(imageUrl: model.image)
//        }
//    }
//}
//class RemoteImageURL: ObservableObject{
//    var didChange = PassthroughSubject<Data, Never>()
//    var data = Data() {
//        didSet {
//            didChange.send(data)
//        }
//    }
//
//    init(imageURL: String) {
//        guard let url = URL(string: imageURL) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//
//            DispatchQueue.main.async { self.data = data }
//            print(data)
//            }.resume()
//    }
//}
//
//struct ImageViewContainer: View {
//    @ObservedObject var remoteImageURL: RemoteImageURL
//
//    init(imageUrl: String) {
//        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
//    }
//
//    var body: some View {
//        print("El Data qui", remoteImageURL.data)
//        return Image(uiImage: UIImage(data: remoteImageURL.data) ?? UIImage())
//            .resizable()
//            .clipShape(Circle())
//            .overlay(Circle().stroke(Color.black, lineWidth: 3.0))
//            .frame(width: 70.0, height: 70.0)
//    }
//}
//
//
///********************************************************************/
//
//struct PruebaView_Previews: PreviewProvider {
//    static var previews: some View {
//        PruebaView()
//    }
//}
//-----------------NO PASA LA INFO


import Combine
import Foundation
import SwiftUI

class ImageLoaderFun: ObservableObject {
    var dataPublisher = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            dataPublisher.send(data)
        }
     }
init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else { return }
        DispatchQueue.main.async {
           self.data = data
        }
    }
    task.resume()
  }
}

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoaderFun
    @State var image:UIImage = UIImage()
init(withURL url:String) {
        imageLoader = ImageLoaderFun(urlString:url)
    }
var body: some View {
    VStack {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:100, height:100)
    }.onReceive(imageLoader.dataPublisher) { data in
        self.image = UIImage(data: data) ?? UIImage()
    }
  }
}
struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "")
    }
}

struct DataRow: View {
    var data: Insumo
    
    var body: some View {
        HStack {
            ImageView(withURL: data.image)
            Text(verbatim: data.image)
        }
    }
}

struct PruebaView : View {
    @ObservedObject var networkingManager = NetworkingManager()

    var body: some View {
        List(networkingManager.insumos) { post in
            DataRow(data: post) // Get image
        }
    }
}


struct PruebaView_Previews: PreviewProvider {
    static var previews: some View {
        PruebaView()
    }
}
