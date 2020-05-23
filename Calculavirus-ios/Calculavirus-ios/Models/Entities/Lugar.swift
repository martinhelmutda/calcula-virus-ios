//
//  Lugar.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 13/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import Foundation
import SwiftUI
import Combine



struct Lugar: Decodable & Identifiable {
    var id: Int
    var nombre: String
    var descripcion: String?
    var image:String?
}

struct LugaresResult:Decodable {
    var results : [Lugar]
}
