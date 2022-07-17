import UIKit
import Moya

enum NetworkServiceReference {
    case photos(dataModel: GetPhotosDataModel)
}

extension NetworkServiceReference: TargetType {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/")!
        }
    }

    public var path: String {
        switch self {
        case .photos:
            return "photos"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .photos:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .photos(let dataModel):
            return .requestParameters(parameters: dataModel.getParameters(), encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .photos:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        }
    }
}

