//
//  LoginViewController.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 14/11/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RegisterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var MainContentView: UIView!
    @IBOutlet weak var LoginScrollView: UIScrollView!

    
    
    private var viewModel = LoginViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        enableKeyboardHandling(for: LoginScrollView)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupUI()
        bindViewModel()
    }

    private func setupUI() {

        self.emailTextField.layer.cornerRadius = 25
        self.PasswordTextField.layer.cornerRadius = 25
        self.emailTextField.clipsToBounds = true
        self.PasswordTextField.clipsToBounds = true
        self.emailTextField.layer.borderWidth = 1
        self.PasswordTextField.layer.borderWidth = 1
        self.emailTextField.layer.borderColor = UIColor.gray.cgColor
        self.PasswordTextField.layer.borderColor = UIColor.gray.cgColor

        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.black.cgColor
        self.loginBtn.layer.borderWidth = 1
        self.loginBtn.layer.borderColor = UIColor.gray.cgColor
        

        addLeftIcon(
            UIImage(systemName: "envelope.fill")!,
            to: self.emailTextField
        )
        addLeftIcon(
            UIImage(systemName: "key.viewfinder")!,
            to: self.PasswordTextField
        )
        addAddributedText(
            "Didn't have a Account? Register",
            rangeText: "Register",
            to: self.RegisterLabel
        )

        self.RegisterLabel.isUserInteractionEnabled = true
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
        self.RegisterLabel.addGestureRecognizer(tapGesture)

    }

    @objc func contentTapped(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @objc func registerTapped(_ gesture: UITapGestureRecognizer) {
        let text = "Didn't have a Account? Register"
        let targetWord = "Register"

        guard let label = gesture.view as? UILabel else { return }
        let range = (text as NSString).range(of: targetWord)

        if gesture.didTapAttributedTextInLabel(label: label, targetRange: range)
        {
            print("Register tapped!")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            pushSlideFromRight(vc)

        }
    }

    private func bindViewModel() {

        viewModel.onError = { [weak self] message in
            self?.showAlert(title: "Error", message: message)
        }

        viewModel.onSuccess = { [weak self] user in
            self?.showAlert(title: "Success", message: "Welcome \(user.name)")
        }

        viewModel.onLoading = { isLoading in
            print(isLoading ? "Loading..." : "Done")
        }

    }
    
    


    @IBAction func onLoginBtnClicked(_ sender: Any) {

        let email = emailTextField.text ?? ""
        let password = PasswordTextField.text ?? ""

        viewModel.login(email: email, password: password)
    }

}
