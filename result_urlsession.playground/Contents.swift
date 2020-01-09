import UIKit

extension URLSession {
    enum DataError : Error {
        case noData
    }
    
    func dataTask<T:Decodable>(with url: URL, _ decoder: JSONDecoder = JSONDecoder(), completionHandler: @escaping (Result<T, Error>)->()) -> URLSessionDataTask {
        self.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(DataError.noData))
                return
            }
            
            do {
                let obj = try decoder.decode(T.self, from: data)
                completionHandler(.success(obj))
                
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func dataTask<T:Decodable>(with urlRequest: URLRequest, _ decoder: JSONDecoder = JSONDecoder(), completionHandler: @escaping (Result<T, Error>)->()) -> URLSessionDataTask {
        self.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(DataError.noData))
                return
            }
            
            do {
                let obj = try decoder.decode(T.self, from: data)
                completionHandler(.success(obj))
                
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}

struct UserData: Codable {
    let data: User
}

struct User: Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: URL
}

URLSession.shared.dataTask(with: URL(string: "https://reqres.in/api/users/2")!) { (result: Result<UserData, Error>) in
    switch result {
    case .success(let userData):
        print(userData.data.first_name)
    case .failure(let error):
        print(error)
    }
}.resume()

// prints: Janet

URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://reqres.in/api/users/3")!)) { (result: Result<UserData, Error>) in
    switch result {
    case .success(let userData):
        print(userData.data.first_name)
    case .failure(let error):
        print(error)
    }
}.resume()

// prints: Emma
