//
//  SignUpViewController.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 15/11/25.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var MainContentView: UIView!

    @IBOutlet weak var SignupScrollView: UIScrollView!

    @IBOutlet weak var ContainerView: UIView!
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var phoneTextField: UITextField!

    @IBOutlet weak var PasswordTextField: UITextField!

    @IBOutlet weak var ConfirmPasswordTextField: UITextField!

    @IBOutlet weak var signUpBtn: UIButton!

    @IBOutlet weak var signInTextfield: UILabel!
    
    

    private let ViewModel = SignUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        enableKeyboardHandling(for: SignupScrollView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        
        addLeftIcon(
            UIImage(systemName: "person.fill")!,
            to: self.userNameTextField
        )
        
        addLeftIcon(
            UIImage(systemName: "envelope.fill")!,
            to: self.emailTextField
        )
        addLeftIcon(
            UIImage(systemName: "phone.circle.fill")!,
            to: self.phoneTextField
        )
        addLeftIcon(
            UIImage(systemName: "key.viewfinder")!,
            to: self.PasswordTextField
        )
        addLeftIcon(
            UIImage(systemName: "key.viewfinder")!,
            to: self.ConfirmPasswordTextField
        )

        self.ContainerView.layer.cornerRadius = 10
        self.ContainerView.layer.masksToBounds = true
        self.ContainerView.layer.borderColor = UIColor.black.cgColor
        self.ContainerView.layer.borderWidth = 1.0
        
        self.userNameTextField.layer.cornerRadius = 25
        self.userNameTextField.layer.borderWidth = 1
        self.userNameTextField.layer.borderColor = UIColor.gray.cgColor
        self.userNameTextField.clipsToBounds = true

        self.emailTextField.layer.cornerRadius = 25
        self.emailTextField.layer.borderWidth = 1
        self.emailTextField.layer.borderColor = UIColor.gray.cgColor
        self.emailTextField.clipsToBounds = true

        self.phoneTextField.layer.cornerRadius = 25
        self.phoneTextField.layer.borderWidth = 1
        self.phoneTextField.layer.borderColor = UIColor.gray.cgColor
        self.phoneTextField.clipsToBounds = true

        self.PasswordTextField.layer.cornerRadius = 25
        self.PasswordTextField.layer.borderWidth = 1
        self.PasswordTextField.layer.borderColor = UIColor.gray.cgColor
        self.PasswordTextField.clipsToBounds = true

        self.ConfirmPasswordTextField.layer.cornerRadius = 25
        self.ConfirmPasswordTextField.layer.borderWidth = 1
        self.ConfirmPasswordTextField.layer.borderColor = UIColor.gray.cgColor
        self.ConfirmPasswordTextField.clipsToBounds = true

        self.signUpBtn.layer.borderWidth = 1
        self.signUpBtn.layer.borderColor = UIColor.gray.cgColor
        self.signUpBtn.layer.cornerRadius = 25

        self.signInTextfield.isUserInteractionEnabled = true
        self.MainContentView.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(registerTapped)
        )

        let tapGesture1 = UITapGestureRecognizer(
            target: self,
            action: #selector(contentTapped)
        )
        self.MainContentView.addGestureRecognizer(tapGesture1)
        self.signInTextfield.addGestureRecognizer(tapGesture)

        addAddributedText(
            "Already A Member? Sign in",
            rangeText: "Sign in",
            to: self.signInTextfield
        )

    }

    @objc func contentTapped(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @objc func registerTapped(_ gesture: UITapGestureRecognizer) {
        let text = "Already A Member? Sign in"
        let targetWord = "Sign in"

        guard let label = gesture.view as? UILabel else { return }
        let range = (text as NSString).range(of: targetWord)

        if gesture.didTapAttributedTextInLabel(label: label, targetRange: range)
        {
            print("sign in tapped!")

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc =
                storyboard.instantiateViewController(
                    withIdentifier: "LoginViewController"
                ) as! LoginViewController
            pushSlideFromRight(vc)

        }
    }

    private func bindViewModel() {
        ViewModel.isLoading = { isLoading in
            print(isLoading ? "Loading.." : "Done")

        }

        ViewModel.onError = { [weak self] error in
            self?.showAlert(title: "Error", message: error)
        }

        ViewModel.onSuccessful = { [weak self] user in
            self?.showAlert(
                title: "Success",
                message: "User Signed Up Successfully"
            )

        }

    }

    @IBAction func OnSignUpBtnClicked(_ sender: Any) {
        print("Sign Up Button Clicked")

        let name = self.userNameTextField.text ?? ""
        let email = self.emailTextField.text ?? ""
        let phone = self.phoneTextField.text ?? ""
        let password = self.PasswordTextField.text ?? ""
        let confirmpass = self.ConfirmPasswordTextField.text ?? ""

        let req = SignUpRequest(
            name: name,
            email: email,
            phone: phone,
            password: password,
            confirmPassword: confirmpass
        )

        ViewModel.signUp(param: req)
    }

}
