//
//  LoginViewModel.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 15/11/25.
//



import Foundation


class LoginViewModel {
    // MARK: - Dependencies
    private let service: LoginServiceProtocol


    init(service: LoginServiceProtocol = LoginService()) {
        self.service = service
    }


    // MARK: - Binding Closures
    var onError: ((String) -> Void)?
    var onSuccess: ((User) -> Void)?
    var onLoading: ((Bool) -> Void)?
    



// MARK: - Validations
    func validate(email: String, password: String) -> Bool {
        if email.isEmpty {
            onError?("Email should not be empty")
            return false
        }
        if !isValidEmail(email) {
            onError?("Invalid email format")
            return false
        }
        if password.isEmpty {
            onError?("Password should not be empty")
            return false
        }
        if password.count < 4 {
            onError?("Password must be at least 4 characters")
            return false
        }
        return true
    }


    
    



    func login(email: String, password: String) {
        guard validate(email: email, password: password) else { return }
        onLoading?(true)
        let request = LoginRequest(username: email, password: password)
        service.login(request: request) { [weak self] result in
            DispatchQueue.main.async {
                self?.onLoading?(false)
            }
            
            switch result {
            case .success(let response):
                if response.status, let user = response.user {
                    DispatchQueue.main.async {
                        self?.onSuccess?(user)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.onError?(response.message)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}
