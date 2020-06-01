//
//  Insumo.swift
//  CalculaVirus
//
//  Created by Martin Helmut Dominguez Alvarez on 12/05/20.
//  Copyright © 2020 Martin Helmut Dominguez Alvarez. All rights reserved.
//

import Foundation
import SwiftUI
import Combine



//{
//    "id": 1,
//    "nombre": "Mezcal el pescador de sueños",
//    "marca": "Pescador de sueños",
//    "descripcion": "Un Mezcal de los dioses",
//    "lugar_compra": "http://127.0.0.1:8000/lugares/1/",
//    "categoria": "Elíxir",
//    "caducidad": "2022-09-03T00:00:00Z",
//    "cantidad": "1",
//    "prioridad": 5,
//    "duracion_promedio": 1234,
//    "image": "http://127.0.0.1:8000/media/products/None/images_f4XgBiS.jpeg"
//    "user": "http://127.0.0.1:8000/users/1/"
//}

struct Insumo: Decodable & Identifiable {
    var id: Int
    var nombre: String
    var marca: String?
    var descripcion: String?
    var lugar_compra: String
    var categoria: String?
    var caducidad: String?
    var cantidad: String
    var prioridad: Int
    var duracion_promedio: Int
    var image:String?
    var user:String
}

struct InsumosResult:Decodable {
    var results : [Insumo]
    
}
