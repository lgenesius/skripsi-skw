//
//  Decodable+Ext.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import Foundation

extension Decodable {
    init(fromDictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}
