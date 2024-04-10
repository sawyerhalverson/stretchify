import Foundation

struct Stretch: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let tags: [String]
    let switch_sides: Bool
}
