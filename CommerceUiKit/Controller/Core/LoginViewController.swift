//
//  LoginViewController.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 31.08.2022.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    //MARK: UI
    private lazy var emailTextField: UITextField = {
       let field = UITextField()
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.layer.cornerRadius = 8
        field.backgroundColor = .white
        field.placeholder = "Email"
        return field
    }()
    
    private lazy var passTextField: UITextField = {
       let field = UITextField()
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.layer.cornerRadius = 8
        field.isSecureTextEntry = true
        field.backgroundColor = .white
        field.placeholder = "Pass"
        return field
    }()
    
    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .orange
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        // Do any additional setup after loading the view.
        makeConstraints()
        addTargets()
    }
    
    
    func makeConstraints(){
        view.addSubview(loginBtn)
        view.addSubview(passTextField)
        view.addSubview(emailTextField)
        
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
                .offset(-30)
            make.width.equalTo(350)
            make.height.equalTo(40)
        }
        passTextField.snp.makeConstraints { make in
            make.bottom.equalTo(loginBtn.snp.top)
                .offset(-10)
            make.width.height.equalTo(loginBtn)
            make.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalTo(passTextField.snp.top)
                .offset(-5)
            make.width.height.equalTo(loginBtn)
            make.centerX.equalToSuperview()
        }

        
    }
    
    func addTargets(){
        loginBtn.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
}

extension LoginViewController{
    @objc func loginTapped(){
        guard emailTextField.text != "", passTextField.text != "" else {
            throwAlert(message: "Missing email or pass.")
            return
            
        }
        AuthService.shared.loginAuth(email: emailTextField.text!, pass: passTextField.text!) { result in
            switch result {
            case .failure(let error):
                self.throwAlert(message: "An error occured.")
            case .success(let oke):
                AuthService.shared.accessKey = oke.access_token
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }
        }
    }
}

extension LoginViewController {
    func throwAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
