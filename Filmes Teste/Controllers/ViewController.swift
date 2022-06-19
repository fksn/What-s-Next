//
//  ViewController.swift
//  Filmes Teste
//
//  Created by Francisco Neto on 04/06/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
class ViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        emailFieldtext.text = ""
        passwordFieldtext.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    @IBOutlet weak var loginCenterView: UIView!
    @IBOutlet weak var emailFieldtext: UITextField!
    @IBOutlet weak var passwordFieldtext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginCenterView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        loginCenterView.layer.cornerRadius = 20
        loginCenterView.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailFieldtext.text, let password = passwordFieldtext.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let erro = error{
                    print(erro.localizedDescription)
                    let alert = UIAlertController(title: "Erro", message: erro.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.performSegue(withIdentifier: "LoginToApp", sender: self)
                }
            }
        }
    }
}

