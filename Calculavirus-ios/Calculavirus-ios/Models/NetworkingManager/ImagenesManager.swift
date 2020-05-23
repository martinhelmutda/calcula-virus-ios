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
