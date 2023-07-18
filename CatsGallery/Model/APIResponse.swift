//
//  APIResponse.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

// Uso de Generics por conta de alguns tipos desconhecidos
// Aplicados aos campos encontrados na requisição que não possuem nenhum valor
// Ou seja, todos valendo null no JSON para a response inteira
// <V: Codable, A: Codable, IV: Codable, IT: Codable>
struct APIResponse: Codable {
    let data: [CatsData]?
    let success: Bool?
    let status: Int?
}
