import Foundation

struct Person: Codable {
    var name: String
    var age: Int
}

let taylor = Person(name: "Faustão", age: 68)
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let decoder = JSONDecoder()

do {
    let encoded = try encoder.encode(taylor)
    let json = String(decoding: encoded, as: UTF8.self)
    print("JSON criado: \(json)")

    let decoder = JSONDecoder()
    let person = try decoder.decode(Person.self, from: encoded)
    print("Objeto decodificado: \(person)")
} catch {
    print(error.localizedDescription)
}
