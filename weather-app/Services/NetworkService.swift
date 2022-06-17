//
//  NetworkService.swift
//  weather-app
//
//  Created by Soultan Muhammad Albar on 12/06/22.
//

import Foundation



class NetworkService {

    func performRequest<T: Decodable>(_ modelType: T.Type, with urlString: String, completion: @escaping((Result<Decodable, Error>) -> Void)) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                if let safeData = data {
                    if let result = self.parseJSON(T.self, from: safeData) {
                        completion(.success(result))
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON<T: Decodable>(_ modelType: T.Type, from data: Data) -> Decodable? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            
            return decodedData
            
        } catch {
            print("Error parse JSON \(error)")
            return nil
        }
    }
  
}
