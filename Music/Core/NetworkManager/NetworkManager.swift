//
//  NetworkManager.swift
//  Music
//
//  Created by Margarita Slesareva on 31.03.2022.
//

import Foundation

protocol NetworkManager {
    func sendRequest(request: Request, completion: @escaping (Result<Data, RequestError>) -> Void)
}
