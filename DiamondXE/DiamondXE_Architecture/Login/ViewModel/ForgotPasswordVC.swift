//
//  ForgotPasswordVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 19/04/24.
//

import UIKit


class ForgotPasswordVC: BaseViewController {
   
    @IBOutlet weak var viewEnterEmail: UIView!
    @IBOutlet weak var viewEnterOTP: UIView!
    @IBOutlet weak var btnResendOTP: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var txtEmail: FloatingTextField!
    @IBOutlet weak var txtOTP: FloatingTextField!
    
    var forgotPassParamStruct = ForgotPassParamStruct()
    var resetPassParam = ResetPasswordStruct()


    
    var isReset = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.viewEnterOTP.isHidden = true
        self.timerLabel.isHidden  = true
        self.btnResendOTP.isHidden  = true
        
        self.txtEmail.placeholderColor = .themeClr
        self.txtEmail.floatPlaceholderActiveColor = .themeClr
        self.txtOTP.placeholderColor = .themeClr
        self.txtOTP.floatPlaceholderActiveColor = .themeClr
        self.txtEmail.floatPlaceholderColor = .themeClr
        self.txtOTP.floatPlaceholderColor = .themeClr
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionResendOTP(_ sender: UIButton){
        print("Resent")
    }
    
    @IBAction func btnActionContinue(_ sender: UIButton){
        
        if isReset {
            guard validateDataEmail() else { return }
            self.forgotPassParamStruct.userType = "buyer"
            self.forgotPassParamStruct.email = "vijayd@mailinator.com"
            
            var parameters : [String:Any]?
            parameters =  [
                "userType": self.forgotPassParamStruct.userType ?? "",
                "email": self.forgotPassParamStruct.email ?? ""
            ]
            
            if let param = parameters{
                self.getOTPONMail(param: param)
            }
        }
        else{
            guard validateDataOTP() else { return }
            
            self.resetPassParam.email = "vijayd@mailinator.com"
            self.resetPassParam.otp = 1234
            self.resetPassParam.resetPassword = 0
            
            var parameters : [String:Any]?
            parameters =  [
                "email": self.resetPassParam.email ?? "",
                 "otp": self.resetPassParam.otp ?? 0,
                "resetPassword": self.resetPassParam.resetPassword ?? 0
            ]
            
            if let param = parameters{
                self.verifyOTP(param: param)
            }
           
        }
            
            
        }
        
        func validateDataEmail() -> Bool {
            
            guard !txtEmail.text!.isEmptyStr else {
                txtEmail.showError(message: ConstentString.emailErr)
                return false
            }
            
            
            return true
        }
        
        func validateDataOTP() -> Bool {
            
            guard !txtOTP.text!.isEmptyStr else {
                txtOTP.showError(message: ConstentString.emailErr)
                return false
            }
            
            
            return true
        }
        
        
        
    func getOTPONMail(param : [String:Any]) {
            // callAPI_Login
            view.endEditing(true)
            CustomActivityIndicator.shared.show(in: view)
            LoginDataModel().forgotPassword(url: APIs().forgot_passwordAPI, requestParam: param, completion: { response , message in
                print(response)
                if response.status == 1{
                    //print(message)
                    self.viewEnterOTP.isHidden = false
                    self.timerLabel.isHidden  = false
                    self.btnResendOTP.isHidden  = false
                    self.isReset = false
                    self.btnResendOTP.isEnabled = false
                    TimerManager.shared.startTimer(withLabel: self.timerLabel) {
                        self.btnResendOTP.isEnabled = true
                    }
                }
                else{
                    self.toastMessage(message ?? "")
                }
                
                CustomActivityIndicator.shared.hide()
                
            })
            
           
        }
    
    func verifyOTP(param : [String:Any]) {
            // callAPI_Login
            view.endEditing(true)
            CustomActivityIndicator.shared.show(in: view)
            LoginDataModel().resetPassword(url: APIs().reset_passwordAPI, requestParam: param, completion: { response , message in
               
                if response.status == 1{
                    self.toastMessage(message ?? "")
                    let data = self.resetPassParam
                    self.navigationManager(ResetPasswordVC.self, storyboardName: "Login", storyboardID: "ResetPasswordVC", data: data)
                    
                    print(self.resetPassParam)
                }
                else{
                    self.toastMessage(message ?? "")
                }
                
                CustomActivityIndicator.shared.hide()
                
            })
            
           
        }
    
    
    
}
