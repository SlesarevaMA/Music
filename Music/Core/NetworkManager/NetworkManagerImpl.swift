//
//  NetworkManagerImpl.swift
//  Music
//
//  Created by Margarita Slesareva on 31.03.2022.
//

import Foundation

final class NetworkManagerImpl: NetworkManager {
    func sendRequest(request: Request, completion: @escaping (Result<Data, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200, let data = data {
                 completion(.success(data))
             } else {
                 completion(.failure(RequestError.downloadFail))
            }
        }
        
        dataTask.resume()
    }
}
