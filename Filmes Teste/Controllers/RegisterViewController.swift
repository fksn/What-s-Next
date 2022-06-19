//
//  RegisterViewController.swift
//  Filmes Teste
//
//  Created by Francisco Neto on 05/06/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
class RegisterViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        emailFieldtext.text = ""
        passwordFieldtext.text = ""
    }
    @IBOutlet weak var emailFieldtext: UITextField!
    @IBOutlet weak var passwordFieldtext: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailFieldtext.text, let password = passwordFieldtext.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let erro = error{
                    print(erro.localizedDescription)
                    let alert = UIAlertController(title: "Erro", message: erro.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } else{
                    self.performSegue(withIdentifier: "RegisterToApp", sender: self)
                }
            }
        }
    }
}
