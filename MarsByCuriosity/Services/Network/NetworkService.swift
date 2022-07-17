import Foundation
import Moya

struct NetworkService {
    //MARK: - Properties
    #if DEBUG
    private let provider = MoyaProvider<NetworkServiceReference>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
    #else
    private let provider = MoyaProvider<NetworkServiceReference>()
    #endif
    
    //MARK: - Flow functions
    func stopTasks() {
        provider.session.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }
    
    func getPhotos(target: NetworkServiceReference, completion: @escaping (PhotosResponseObject?) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                let photosObject = try? response.map(PhotosResponseObject.self)
                completion(photosObject)
            case .failure:
                completion(nil)
            }
        }
    }
}
