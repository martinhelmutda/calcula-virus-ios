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
import Alamofire
import SwiftyJSON

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

class ImageUploader {
    
    static func uploadPhoto(_ url: String, image: UIImage?, params: [String : Any], header: [String:String]) {
        let httpHeaders = HTTPHeaders(header)
        AF.upload(multipartFormData: { multiPart in
            for p in params {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            if(image != nil){
                multiPart.append(image.jpegData(compressionQuality: 0.4)! ?? Data(), withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
            }
            
        }, to: url, method: .post, headers: httpHeaders) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseString(completionHandler: { data in
            print("upload finished: \(data)")
        }).response { (response) in
            switch response.result {
            case .success(let result):
                print("upload success result: \(String(describing: result))")
            case .failure(let err):
                print("upload err: \(err)")
            }
        }
    }
    
}
