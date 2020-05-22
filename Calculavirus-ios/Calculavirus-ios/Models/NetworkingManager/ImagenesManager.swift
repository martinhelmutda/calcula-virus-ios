//
//  ImageLoader.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 19/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    var downloadedImage: UIImage?
    let didChange = PassthroughSubject<ImageLoader?, Never>()
    
    func load(url: String) {
        
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            
            guard let dataImg = data, error == nil else {
                DispatchQueue.main.async {
                     self.didChange.send(nil)
                }
                return
            }
            self.downloadedImage = UIImage(data: dataImg)
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
            
        }.resume()
        
    }
}
