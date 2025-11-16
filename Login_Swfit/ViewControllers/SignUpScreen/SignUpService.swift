//
//  SignUpService.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 16/11/25.
//


import Foundation

protocol SignUpServiceProtocol{
    func signUp(request:SignUpRequest, completion: @escaping (Result<SignUpResponse,Error>)->Void)
}



class SignUpService:SignUpServiceProtocol{
    
    
    func signUp(request: SignUpRequest, completion: @escaping (Result<SignUpResponse, any Error>) -> Void) {
        guard let url = URL(string: DOMAIN_URL + ApiEndPoint.signup.rawValue) else {return}
        
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
                    SignUpResponse.self,
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
