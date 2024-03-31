//
//  NetworkService.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import UIKit

protocol INetworkService {
    func getDataAdvertisement(urlString: String, completion: @escaping (Result<ResponseDataModel, Error>) -> Void)
}

final class NetworkService: INetworkService {
    
    func getDataAdvertisement(urlString: String, completion: @escaping (Result<ResponseDataModel, Error>) -> Void) {
        request(urlString: urlString, completion: completion)
    }
    
    private func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void ) {
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let tracks = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(tracks))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
}
