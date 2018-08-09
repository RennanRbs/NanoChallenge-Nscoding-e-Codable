import Foundation
import UIKit

// Estrutura guarda uma String (Codable) e uma UIColor (NSCoding).
struct Person {
    var name: String
    var favoriteColor: UIColor
}

// Extension para colocar as funcionalidades de Codable.
extension Person: Codable {
    // Como é preciso codificar e decodificar manualmente, é preciso declarar
    // as CodingKeys explicitamente.
    enum CodingKeys: String, CodingKey {
        case name
        case favoriteColor
    }

    // Esse método faz a decodificação, ou seja, pega a raw data e converte
    // para um UIColor novamente.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Salva diretamente o name, pois é codable.
        name = try container.decode(String.self, forKey: .name)

        // No caso da UIColor, é preciso decodificar como Data e depois obter novamente, mas
        // como é feito com o NSCoding.
        let colorData = try container.decode(Data.self, forKey: .favoriteColor)
        favoriteColor = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor ?? UIColor.black
    }

    // Esse método faz a codificação. Para isso, transforma UIColor para um objeto Data e
    // ele é codificado.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)

        // Transforma a UIColor para "raw data".
        let colorData = NSKeyedArchiver.archivedData(withRootObject: favoriteColor)
        try container.encode(colorData, forKey: .favoriteColor)
    }
}

let taylor = Person(name: "Taylor Swift", favoriteColor: .blue)
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let decoder = JSONDecoder()

do {
    let encoded = try encoder.encode(taylor)
    let json = String(decoding: encoded, as: UTF8.self)
    print("JSON criado: \(json)")
    
    let decoder = JSONDecoder()
    let person = try decoder.decode(Person.self, from: encoded)
    print(person)
} catch {
    print(error.localizedDescription)
}
