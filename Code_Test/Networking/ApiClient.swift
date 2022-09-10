//
//  ApiClient.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import Foundation
import RxSwift

class ApiClient {
    static let shared = ApiClient()
    
    func request(url : String,
                          method : RequestType = .GET,
                          parameters : [String : String] = [:]) -> Observable<Any> {
        
        let baseURL = URL(string: url)!
        
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }

        guard let url = components.url else {
            fatalError("Could not get url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return Observable.create { [unowned self] observer in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
                if let error = error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
