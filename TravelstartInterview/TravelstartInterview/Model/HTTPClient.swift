//
//  HTTPClient.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/4.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import Foundation

enum Result<T> {
    
    case success(T)
    
    case failure(Error)
}

enum HTTPMethod: String {
    
    case GET
    
}

enum HTTPClientError: Error {

    case authorizationError

    case decodeDataFail

    case clientError(Data)

    case serverError

    case unexpectedError
}

protocol Request {
    
    var headers: [String: String]? { get }

    var body: Data? { get }

    var method: String { get }

    var endPoint: URL { get }
}

class HTTPClient {
    
    private init() { }
    
    static let shared = HTTPClient()

    private let decoder = JSONDecoder()

    private let encoder = JSONEncoder()

    func request(
            _ request: Request,
            _ completion: @escaping (Result<Data>) -> Void) {
        
            URLSession.shared.dataTask(
                with: makeRequest(request),
                completionHandler: { (data, response, error) in
        
                guard error == nil else {

                    return completion(.failure(HTTPClientError.unexpectedError))
                   
                }

                // swiftlint:disable force_cast
                let httpResponse = response as! HTTPURLResponse
                // swiftlint:enable force_cast
                let statusCode = httpResponse.statusCode

                switch statusCode {

                case 200..<300:

                    completion(.success(data!))

                case 400..<500:

                    completion(.failure(HTTPClientError.clientError(data!)))

                case 500..<600:

                    completion(.failure(HTTPClientError.serverError))

                default: return

                    completion(.failure(HTTPClientError.unexpectedError))
                }

            }).resume()
        }

    private func makeRequest(_ request: Request) -> URLRequest {

        var urlRequest = URLRequest(url: request.endPoint)

        urlRequest.allHTTPHeaderFields = request.headers

        urlRequest.httpMethod = request.method

        urlRequest.httpBody = request.body
            
        return urlRequest

    }
}
