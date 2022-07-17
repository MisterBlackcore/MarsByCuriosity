import UIKit

struct CameraDropDownMenuDataSource {
    //MARK: - Properites
    private let cameraItems = [
        CameraItem(abbreviation: "FHAZ", cameraName: "Front Hazard Avoidance Camera"),
        CameraItem(abbreviation: "RHAZ", cameraName: "Rear Hazard Avoidance Camera"),
        CameraItem(abbreviation: "MAST", cameraName: "Mast Camera"),
        CameraItem(abbreviation: "CHEMCAM", cameraName: "Chemistry and Camera Complex"),
        CameraItem(abbreviation: "MAHLI", cameraName: "Mars Hand Lens Imager"),
        CameraItem(abbreviation: "MARDI", cameraName: "Mars Descent Imager"),
        CameraItem(abbreviation: "NAVCAM", cameraName: "Navigation Camera"),
        CameraItem(abbreviation: "PANCAM", cameraName: "Panoramic Camera"),
        CameraItem(abbreviation: "MINITES", cameraName: "Miniature Thermal Emission Spectrometer (Mini-TES)")
    ]
    
    //MARK: - Flow functions
    func getDropDownMenuItems() -> [String] {
        let cameraNames = cameraItems.map { $0.cameraName }
        return cameraNames
    }
    
    func getCameraItem(at index: Int?) -> CameraItem? {
        guard let index = index else {
            return nil
        }
        return cameraItems[index]
    }
}

struct CameraItem {
    var abbreviation: String
    var cameraName: String
}
