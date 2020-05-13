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
//         "nombre": "Leche Deslactosada",
//         "descripcion": "Bebida deslactosada de marca Lala",
//         "lugar_compra": "Walmart",
//         "categoria": "Lácteos",
//         "caducidad": "2020-08-12T00:00:00Z",
//         "cantidad": "2",
//         "prioridad": 4,
//         "duracion_promedio": 3
//     }

struct Insumo: Decodable & Identifiable {
    var id: Int
    var nombre: String
    var descripcion: String
    var lugar_compra: String
    var categoria: String
    var caducidad: String
    var cantidad: String
    var prioridad: Int
    var duracion_promedio: Int

}

struct InsumosResult:Decodable {
    var results : [Insumo]
    
}
