//
//  NetworkManager.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 24.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

protocol ExitViewProtocol: class {
    func exit()
}

class NetworkManager {

    static let sharedManager = NetworkManager()
    public var unsplashToken:UnsplashAccessToken?
    var networkTask: URLSessionDataTask?

    var networkExitViewProtocol: ExitViewProtocol?

    public func authorizeFromController(controller: UIViewController, completion:@escaping (Bool, Error?) -> Void) {
          precondition(UnsplashAuthManager.sharedAuthManager != nil, "call `UnsplashAuthManager.init` before calling this method")

           UnsplashAuthManager.sharedAuthManager.authorizeFromController(controller: controller, completion: { token, error in
               if let accessToken = token {
                   self.unsplashToken = accessToken


                UserSettings.isLoggedIn = true

                guard let token =  accessToken.accessToken else { return }


                UserSettings.userToken = token

                ///метод
                self.networkExitViewProtocol?.exit()
                
                   print("######   \(String(describing: accessToken.accessToken))          ####")
                   completion(true, nil)


               } else  {
                   completion(false, error!)
               }
           })
       }

    public func setUpWithAppId(appId : String, secret : String, scopes: [String] = UnsplashAuthManager.allScopes) {

        UnsplashAuthManager.sharedAuthManager = UnsplashAuthManager(appId: appId, secret: secret, scopes: scopes)
        if let token = UnsplashAuthManager.sharedAuthManager.getAccessToken() {
            self.unsplashToken = token
        }
    }

    func makeNetworkCall(requestHelper: RequestHelper, requestCompletionBlock:@escaping((Any?, Error?) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            self.networkTask =  session.dataTask(with: requestHelper.requestURL) { [weak self] (data, response, error) in
                guard let strongSelf = self else { return }
                strongSelf.networkTask = nil
                if let error = error {
                    requestCompletionBlock(nil, error)
                    return
                }

                if let responseData = data,
                    let httpResponse = response as? HTTPURLResponse {
                    print("httpResponse status code \(httpResponse.statusCode)")
                    switch(httpResponse.statusCode) {
                    case 200:
                        guard let JSONObject = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                            print("error trying to convert data to JSON")
                            requestCompletionBlock(nil, WebServiceError.parserError(200, "response json invalid"))
                            return
                        }
                        requestCompletionBlock(JSONObject, nil)

                    default:
                        guard (try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject]) != nil  else {
                            print("error trying to convert data to JSON")
                            requestCompletionBlock(nil, WebServiceError.parserError(220, "response json invalid"))
                            return
                        }
                        print("POST resquest not successful. http status code \(httpResponse.statusCode)")
                        requestCompletionBlock(nil, WebServiceError.APIError(httpResponse.statusCode, "Somthing wrong happened, please try after some time"))
                    }
                } else {
                    print("not a valid http response")
                    requestCompletionBlock(nil, WebServiceError.APIError(400, "Bad request"))
                }
            }
            self.networkTask?.resume()
        }
    }

}
