//
//  RequestManager.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import Foundation
import Combine
import Alamofire

enum RequestError: Error {
    case noData
    case parseError(Error)
    case httpRequestError(Error)
}

class RequestManager {
    static let shard = RequestManager()
    
    private var defaultJSONDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func request<T: Decodable>(path: String,
                               responseModelType: T.Type,
                               param: [String: Any]? = nil) -> AnyPublisher<T, RequestError>  {
        return Future { promiss in
            let requestUrlString = Config.baseURLString + path
            AF.request(requestUrlString, method: .get, parameters: param).validate().responseJSON { response in
                if let error = response.error {
                    promiss(.failure(.httpRequestError(error)))
                    return
                }
                guard let data = response.data else {
                    promiss(.failure(.noData))
                    return
                }
                do {
                    let result = try self.defaultJSONDecoder.decode(responseModelType, from: data)
                    promiss(.success(result))
                } catch let error {
                    promiss(.failure(.parseError(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}
