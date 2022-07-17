import UIKit

struct GetPhotosDataModel {
    var earthDate: String?
    var camera: CameraItem?
    var apiKey = "mnnNZoE40ou0NHqrg2OAV7RTRsoWk4hGciq8gvFQ"
    
    func getParameters() -> [String: Any] {
        var parameters = ["api_key": apiKey]
        parameters["earth_date"] = getEarthDateForParameters()
        if let camera = camera {
            parameters["camera"] = camera.abbreviation
        }
        return parameters
    }
    
    private func getEarthDateForParameters() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        guard let earthDate = earthDate else {
            return nil
        }
        let showDate = dateFormatter.date(from: earthDate)
        dateFormatter.dateFormat = "YYYY-MM-DD"
        guard let showDate = showDate else {
            return nil
        }
        let resultDate = dateFormatter.string(from: showDate)
        return resultDate
    }
}
