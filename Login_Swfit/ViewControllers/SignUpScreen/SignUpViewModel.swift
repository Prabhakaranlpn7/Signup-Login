//
//  SignUpViewModel.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 16/11/25.
//

import Foundation



class SignUpViewModel{
    
    private let service: SignUpServiceProtocol
    
    init(service: SignUpServiceProtocol = SignUpService()) {
        self.service = service
    }
    
    
    var isLoading:((Bool)->Void)?
    var onSuccessful:((user)->Void)?
    var onError:((String)->Void)?
    
    
    
    private func validateFields(_ param: SignUpRequest) {
        
        guard !param.name.isEmpty else {
            self.onError?("Please enter name")
            return
        }
        
        guard !param.email.isEmpty else {
            self.onError?("Please enter email")
            return
        }
        
        guard isValidEmail(param.email) else{
            self.onError?("Please enter valid email")
            return
        }
        
        guard !param.phone.isEmpty else {
            self.onError?("Please enter phone number")
            return
        }
        
        guard param.phone.count == 10 else {
            self.onError?("Phone number must be 10 digits")
            return
        }

        guard CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: param.phone)) else {
            self.onError?("Phone number must contain numbers only")
            return
        }

        guard !param.password.isEmpty else {
            self.onError?("Please enter password")
            return
        }

        guard param.password.count >= 4 else {
            self.onError?("Password must be at least 4 characters")
            return
        }

        guard !param.confirmPassword.isEmpty else {
            self.onError?("Please enter confirm password")
            return
        }

        guard param.confirmPassword.count >= 4 else {
            self.onError?("Confirm password must be at least 4 characters")
            return
        }

        guard param.password == param.confirmPassword else {
            self.onError?("Password and confirm password must match")
            return
        }
    }
    
    
    
    func signUp(param: SignUpRequest) {
        
        validateFields(param)
        
        self.isLoading?(true)
        
        service.signUp(request: param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading?(false)
            }
            print("result = ",result)
            switch result {
            case .success(let response):
                if response.status, let user = response.user {
                    DispatchQueue.main.async {
                        self?.onSuccessful?(user)
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
