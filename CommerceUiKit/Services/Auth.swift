//
//  Auth.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 31.08.2022.
//

import Foundation

class AuthService{
    static let shared = AuthService()
    
    func loginAuth(email:String, pass: String, completion: @escaping (Result<AuthResponse, Error>)->Void){
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/auth/login") else {
            completion(.failure(APIError.badURL))
            return
        }
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let body: [String: Any] = [
            "email": email,
            "password": pass
        ]
        request.httpBody = body.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data else {return}
            do {
                let response = try JSONDecoder().decode(AuthResponse.self, from: data)
                UserDefaults.standard.set(response.access_token, forKey: "access_token")
                completion(.success(response))
            } catch let error {
                completion(.failure(APIError.notTranslate))
            }
        }
        task.resume()
    }
    
    var accessKey: String? = UserDefaults.standard.string(forKey: "access_token")
    
    func saveUserDefaults(){
        
    }
    
}

enum APIError: Error {
    case badURL
    case notTranslate

}


