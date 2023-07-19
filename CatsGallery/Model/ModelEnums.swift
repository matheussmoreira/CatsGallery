//
//  ModelEnums.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

enum TypeError: Error {
    case unknownValue
}

/// Enum para criada para alguns campos que não consegui determinar o tipo a partir da response (e também não encontrei nada na documentação).
/// Os campos em questão possuiam valor nulo no JSON inteiro!
enum AnyCodable: Codable {
    case int(Int)
    case string(String)
    case bool(Bool)
    
    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(stringValue)
        } else if let boolValue = try? decoder.singleValueContainer().decode(Bool.self) {
            self = .bool(boolValue)
        } else {
            throw TypeError.unknownValue
        }
    }
}
