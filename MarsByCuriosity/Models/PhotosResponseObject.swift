import UIKit

struct PhotosResponseObject: Codable {
    let photos: [Photo]
}

struct Photo: Codable {
    var id: Int?
    var sol: Int?
    var camera: Camera?
    var img_src: String?
    var earth_date: String?
    var rover: Rover?
}

struct Camera: Codable {
    var id: Int?
    var name: String?
    var rover_id: Int?
    var full_name: String?
}

struct Rover: Codable {
    var id: Int?
    var name: String?
    var landing_date: String?
    var launch_date: String?
    var status: String?
}
