//
//  ResponseSerializer.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 24.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

enum WebServiceError: Error {
    case APIError(Int, String)
    case parserError(Int?, String?)
    case generalError(String)
    case networkError(Int, String)
}
enum JSONResult<Value> {
    case failure(WebServiceError)
    case successWithResult(TCResultData)
    case success(Value)
    case cancelled

}

struct TCResultData: Codable {
    var resultCode: Int
    var resultData: String

    enum CodingKeys: String, CodingKey {
        case resultCode = "ResultCode"
        case resultData = "results"
    }
}

extension JSONDecoder {

    static func convertResponse<T: Decodable>(_ response: Any, ofType: T.Type) -> T? {

        // Since data task callback is deserialising the data sometimes and we've no control over it, we need to reverse engineer to get json object to Data
        guard let data = try? JSONSerialization.data(withJSONObject: response, options: []) else { return nil }

        let jsonDecoder = JSONDecoder()
        var convertedModel: T?
        do {
            convertedModel = try jsonDecoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Json to model conversion error \(key) \(context)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("Json to model conversion error \(type) \(context)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Json to model conversion error \(type) \(context)")
        } catch DecodingError.dataCorrupted(let context) {
            print("Json to model conversion error \(context)")
        } catch {
            print("There is some other error ")
        }

        return convertedModel
    }

}
