struct Stretch: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let tags: [String]
    let switchSides: Bool // Renamed switch_sides to switchSides to follow Swift naming convention
    let imageName: String // Add imageName property to store the name of the associated image
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, tags, switchSides = "switch_sides"
        case imageName // Add imageName as a new case
    }
}
