import UIKit

class HTTPNetworking<T: ResourceType>: NSObject, HTTPNetworkingType, URLSessionTaskDelegate {
    
    var isWaitingForConnectivityHandler: ((URLSession, URLSessionTask) -> Void)?

    private var session: HTTPNetworkingSession!
    private let manager = URLSessionManager.shared
    
    override init() {
        super.init()
      manager.taskDelegate = self
      session = manager.session
    }
    
    @discardableResult
    public func request( _ resource: T, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        
        let request = URLRequest(resource: resource)
        
        return session.loadData(with: request) { (data, response, error) in
            print("data", data)
            print("error", error)
            
            if let error = error {
                completion(.failure(error))
            }
            completion(.success(data!))
            
//            completion(Response(response: response, data: data, error: error))
        }
    }
    
    public func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
      isWaitingForConnectivityHandler?(session, task)
    }
    
}
