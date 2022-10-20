//
//  LoginViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/1/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mainViewOutlet: UIView!
    @IBOutlet weak var passwordViewOutlet: UIView!
    @IBOutlet weak var userViewOutlet: UIView!
    @IBOutlet weak var signInBtnRadius: UIButton!
    @IBOutlet weak var loginContentLayout: UIView!
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        performLogin()
        
        return true
    }
    
    
    func performLogin() {
        let providedEmailAddress = UserEmail.text
        let providedPassword = UserPassword.text
        
        if providedEmailAddress == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Please Enter the User ID")
            return
        }
        
        if providedPassword == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Please Enter the Password")
            return
        }
        
        //!---------- Api Call
        
        activitiyViewController.show(existingUiViewController: self)
        var params = Dictionary<String, String>()
            
        params["team_id"] = providedEmailAddress;
        params["team_password"] = providedPassword;
        params["RmemberMe"] = "true";
        let macAddress = UIDevice.current.identifierForVendor?.uuidString
        params["mac_address"] = macAddress;
        
        let ammad = params
        // Api Executed
        Alamofire.request(Constants.LoginApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    let loginModel = Mapper<LoginModel>().map(JSONString: response.value!) //JSON to model
                    
                    if loginModel != nil {
                        
                        if (loginModel?.success)! {
                            
                            let r = Mapper<Result>().toJSONString((loginModel?.result)!, prettyPrint: false); // model to json
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.LOGIN_RESULT, withJson: r!)
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.IsSignInKey, withJson: "1")
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.Employe_Name, withJson: (loginModel?.result?.emp_name)!);
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.EMP_ID, withJson: (loginModel?.result?.emp_id)!);
                            
                            self.performSegue(withIdentifier: "Sendtomainscreen", sender: nil)
                            //dismiss(animated: false, completion: nil)
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (loginModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                })
            })
        
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        performLogin()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id = segue.identifier
        if (id == "Sendtomainscreen") {
            let dest = segue.destination as! MenuViewController
            dest.loginViewController = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserPassword.delegate = self
        
        mainViewOutlet.layer.cornerRadius = 10
        userViewOutlet.layer.cornerRadius = 25
        passwordViewOutlet.layer.cornerRadius = 25
        signInBtnRadius.layer.cornerRadius = 25
        signInBtnRadius.clipsToBounds = true
        
        loginContentLayout.layer.cornerRadius = 25
        loginContentLayout.clipsToBounds = true
        
        let a = CommonUtils.getJsonFromUserDefaults(forKey: Constants.IsSignInKey)
       
        if (a == "0"){
            
            self.UserEmail.text = ""
            self.UserPassword.text = ""
        }
        
        if (a == "1"){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { // change 2 to desired number of seconds
                // Your code with delay
                self.performSegue(withIdentifier: "Sendtomainscreen", sender: nil)
            }
            return
        }
        activitiyViewController = ActivityViewController(message: "Loading...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let a = CommonUtils.getJsonFromUserDefaults(forKey: Constants.IsSignInKey)
        if (a == "0"){
            self.UserEmail.text = ""
            self.UserPassword.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
