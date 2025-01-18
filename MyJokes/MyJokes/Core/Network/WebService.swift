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

actor WebService: ApiClientProtocol {
    
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }
    private let baseURL: String
    
    
    private var ongoingRequests: Int = 0
    private let maxConcurrentRequests: Int = 5
    private var requestQueue: [() async throws -> Void] = []
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
  func request<T: Decodable>(endpoint: RequestProtocol, responseModel: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            addRequest {
                do {
                    let request = try endpoint.asURLRequest(baseURL: self.baseURL)
                    let (data, response) = try await self.session.data(for: request)
                    let decodedResponse = try self.manageResponse(data: data, response: response, responseModel: responseModel)
                    continuation.resume(returning: decodedResponse)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
        
    }
    
    private func manageResponse<T: Decodable>(data: Data, response: URLResponse, responseModel: T.Type) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidHTTPResponse
        }
        do{
            return try JSONDecoder().decode(T.self, from: data)
        }catch{
            throw NetworkError.decodingError
        }
    }
    
    // MARK: - Request queue manager
    private func addRequest(_ request: @escaping () async throws -> Void) {
        requestQueue.append(request)
        processQueue()
    }
    
    private func processQueue() {
        guard ongoingRequests < maxConcurrentRequests, !requestQueue.isEmpty else { return }
        let request = requestQueue.removeFirst()
        ongoingRequests += 1
        
        Task {
           try await request()
            await requestCompleted()
        }
    }
    
    private func requestCompleted() async {
        ongoingRequests -= 1
        processQueue()
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
