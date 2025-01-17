//
//  ApiClientProtocol.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case badUrl
    case badRequestBody
    case unknown
    case invalidHTTPResponse
}


protocol ApiClientProtocol: Sendable{
    func request<T: Decodable>(endpoint: RequestProtocol, responseModel: T.Type) async throws -> T
}

final class WebService: ApiClientProtocol {
    
   
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    

    
    func request<T: Decodable>(endpoint: RequestProtocol, responseModel: T.Type) async throws -> T {
        do {
         
            let request = try endpoint.asURLRequest(baseURL: baseURL)
            print(request)
            let (data, response) = try await session.data(for:request)
            return try self.manageResponse(data: data, response: response)
        } catch let error {
            throw error
        }
    }
    
    private func manageResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
            guard let response = response as? HTTPURLResponse else {
                throw  NetworkError.invalidHTTPResponse
            }
        
            switch response.statusCode {
            case 200...299:
                do {
                    print("\(data.prettyPrintedJSONString ?? " responce is empty")")
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    print("‼️", error)
                    throw NetworkError.decodingError
                }
            default:
                throw NetworkError.unknown
            }
        }
}
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
