//
//  LoginService.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 15/11/25.
//

import Foundation

protocol LoginServiceProtocol {
    func login(
        request: LoginRequest,
        completion: @escaping (Result<LoginResponse, Error>) -> Void
    )
}

class LoginService:LoginServiceProtocol {
    
    func login(
        request: LoginRequest,
        completion: @escaping (Result<LoginResponse, any Error>) -> Void
    ) {

        guard let url = URL(string: DOMAIN_URL + ApiEndPoint.login.rawValue) else {
            return
        }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONEncoder().encode(request)
        URLSession.shared.dataTask(with: req) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(
                    LoginResponse.self,
                    from: data
                )
                print("response:=", response)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
