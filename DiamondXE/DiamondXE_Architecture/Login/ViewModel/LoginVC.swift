//
//  LoginVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/04/24.
//

import UIKit



class LoginVC: BaseViewController {
    
    @IBOutlet weak var txtEmail: FloatingTextField!
    @IBOutlet weak var txtPassword: FloatingTextField!
    @IBOutlet weak var txtPhoneNo: UITextField!
    @IBOutlet weak var txtOTP: FloatingTextField!
    @IBOutlet weak var viewBGButtons: UIView!
    @IBOutlet weak var btnMobile: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewEnterMobilOTP: UIView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnResendOTP: UIButton!
    
    @IBOutlet weak var btnFlag: UIButton!
    @IBOutlet weak var btnContryCode: UIButton!

    
    @IBOutlet weak var btnLoginWithEmail: UIButton!
    @IBOutlet weak var btnLoginWithPhone: UIButton!
    @IBOutlet weak var btnSupplierPhone: UIButton!
    @IBOutlet weak var btnSupplierEmail: UIButton!
    
    
    var isLoginWithMob = false

    var parameters : [String:Any]?
    var loginParamData = LoginParamStruct()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for family in UIFont.familyNames {
//            print("Family: \(family)")
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print("      - \(name)")
//            }
//        }
      
        // Do any additional setup after loading the view.
        self.viewBGButtons.addBottomShadow()
        self.txtEmail.placeholderColor = .themeClr
        self.txtEmail.floatPlaceholderActiveColor = .themeClr
        self.txtPassword.placeholderColor = .themeClr
        self.txtPassword.floatPlaceholderActiveColor = .themeClr
        self.txtEmail.floatPlaceholderColor = .themeClr
        self.txtPassword.floatPlaceholderColor = .themeClr
        self.txtOTP.placeholderColor = .themeClr
        self.txtOTP.floatPlaceholderActiveColor = .themeClr
        self.txtOTP.floatPlaceholderColor = .themeClr


        self.txtEmail.textColor = .blackClr
        self.txtPassword.textColor = .blackClr
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        self.txtEmail.tag = 0
        self.txtPassword.tag = 1
        self.txtPassword.isSecureTextEntry = true
        self.viewPhone.isHidden = true
        self.lblTimer.isHidden = true
        self.btnResendOTP.isHidden = true
        self.btnLoginWithPhone.isHidden = true
        self.btnSupplierPhone.isHidden = true
        let navigationController = UINavigationController(rootViewController: self)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        
        
        
    }
    
    func validateData() -> Bool {
    
        if isLoginWithMob{
            guard !txtPhoneNo.text!.isEmptyStr else {
                self.toastMessage("Enter Phone number")
                return false
            }
            return true
        }
        else{
            guard !txtEmail.text!.isEmptyStr else {
                txtEmail.showError(message: ConstentString.emailErr)
                return false
            }
            
            guard !txtPassword.text!.isEmptyStr else {
                txtPassword.showError(message: ConstentString.passErr)
                return false
            }
            return true
        }
       
    }
    
    
    @IBAction func btnActionCountryList(_ sender: UIButton) {
        if let bottomSheet = UIStoryboard.init(name: TVCellIdentifire.customAlertStoryboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: TVCellIdentifire.customAlertController) as? CountryListVC{
            if #available(iOS 15.0, *) {
                if let sheet = bottomSheet.sheetPresentationController{
                   sheet.detents = [.large()]
                    sheet.prefersScrollingExpandsWhenScrolledToEdge = false

                }
            } else {
            }
                bottomSheet.modalPresentationStyle = .pageSheet
                bottomSheet.countryInfoDelegate = self
                self.present(bottomSheet, animated: true)
            
            }
        
    }
    
    
    @IBAction func btnActionSpplierLogin(_ sender: UIButton) {
        self.navigationManager(storybordName: "Login", storyboardID: "WKWebViewVC", controller: WKWebViewVC())
    }
    
    
    @IBAction func btnActionShowPass(_ sender: UIButton) {
        self.txtPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func btnActionForgotPassword(_ sender: UIButton) {
        self.navigationManager(storybordName: "Login", storyboardID: "ForgotPasswordVC", controller: ForgotPasswordVC())
    }
    
    @IBAction func btnActionSignup(_ sender: UIButton) {
        self.navigationManager(storybordName: "Signup", storyboardID: "SignupVC", controller: SignupVC())
    }
    
    @IBAction func btnActionLogin(_ sender: UIButton) {
        guard validateData() else { return }
        
        self.loginParamData.deviceType = "iOS"
        self.loginParamData.deviceID = self.getSessionUniqID()
        self.loginParamData.sessionID = self.getSessionUniqID()
        self.loginParamData.userType = "Buyer"
        
        
        
        if self.isLoginWithMob{
            self.loginParamData.mobileNo = self.txtPhoneNo.text ?? ""
            self.loginParamData.loginType = "mobile"
            if self.txtOTP.text?.count ?? 0 > 0 {
                self.loginParamData.otp = Int(self.txtOTP.text ?? "1234")
                self.loginParamData.requestOtp = 0
                self.loginParamData.otp =  self.loginParamData.otp
            }
            else{
                self.loginParamData.requestOtp = 1
                self.loginParamData.otp = Int()
                
            }
        }
        else{
            self.loginParamData.loginType = "email"
            self.loginParamData.email = self.txtEmail.text ?? ""
            self.loginParamData.password = self.txtPassword.text ?? ""
        }
        
        
        self.parameters =  [
            "deviceType": self.loginParamData.deviceType ?? "",
            "deviceId": self.loginParamData.deviceID ?? "",
            "sessionId": self.loginParamData.sessionID ?? "",
            "userType": self.loginParamData.userType ?? "",
            "loginType": self.loginParamData.loginType ?? "",
            "email": self.loginParamData.email ?? "",
            "password": self.loginParamData.password ?? "",
            "mobileNo": self.loginParamData.mobileNo ?? "",
            "requestOtp": self.loginParamData.requestOtp ?? 0,
            "otp": self.loginParamData.otp ?? 0
        ]
        
        if let param = self.parameters{
            self.loginWithMobile_Email(parameters: param)
        }
        
    }
    
    // api
    func loginWithMobile_Email(parameters:[String:Any]){
        view.endEditing(true)
        if self.isLoginWithMob{
            // callAPI_Login
            CustomActivityIndicator.shared.show(in: view)
            LoginDataModel().loginUser(url: APIs().email_phone_loginAPI, requestParam: parameters, completion: { loginData , message in
                print(loginData)
                if loginData.status == 2{
                    //print(message)
                    self.viewEnterMobilOTP.isHidden = false
                    self.lblTimer.isHidden = false
                    self.btnResendOTP.isHidden = false
                    TimerManager.shared.startTimer(withLabel: self.lblTimer) {
                        self.btnResendOTP.isEnabled = true
                    }
                    
                }
                else if loginData.status == 1{
                    print("Navigate to Dashboard")
                    self.navigationManager(storybordName: "Dashboard", storyboardID: "DashboardVC", controller: ForgotPasswordVC())
                    self.toastMessage(message ?? "")
                }
                else{
                    //print(message)
                    self.toastMessage(message ?? "")
                }
                CustomActivityIndicator.shared.hide()
                
            })
        }
        else{
            // callAPI_Login
            CustomActivityIndicator.shared.show(in: view)
            LoginDataModel().loginUser(url: APIs().email_phone_loginAPI, requestParam: parameters, completion: { loginData , message in
                print(loginData)
                if loginData.status == 1{
//                    print(message)
                    self.navigationManager(storybordName: "Dashboard", storyboardID: "DashboardVC", controller: ForgotPasswordVC())
                    self.toastMessage(message ?? "")
                    
                }
                else{
                    self.toastMessage(message ?? "")
                }
                CustomActivityIndicator.shared.hide()
                
            })
        }
    }
    
    @IBAction func btnActionEmialORMobile(_ sender: UIButton) {
        if sender.tag < 1{
            self.isLoginWithMob = false
            self.btnEmail.backgroundColor = .themeClr
            self.btnEmail.setTitleColor(.whitClr, for: .normal)
            self.btnMobile.backgroundColor = .whitClr
            self.btnMobile.setTitleColor(.themeClr, for: .normal)
            self.viewPhone.isHidden = true
            self.lblTimer.isHidden = true
            self.btnResendOTP.isHidden = true
            self.btnLoginWithPhone.isHidden = true
            self.btnSupplierPhone.isHidden = true
            self.btnLoginWithEmail.isHidden = false
            self.btnSupplierEmail.isHidden = false
            
        }
        else{
            self.isLoginWithMob = true
            self.btnEmail.backgroundColor = .whitClr
            self.btnEmail.setTitleColor(.themeClr, for: .normal)
            self.btnMobile.backgroundColor = .themeClr
            self.btnMobile.setTitleColor(.whitClr, for: .normal)
            self.viewPhone.isHidden = false
            self.viewEnterMobilOTP.isHidden = true
            self.lblTimer.isHidden = true
            self.btnResendOTP.isHidden = true
            self.btnLoginWithPhone.isHidden = false
            self.btnSupplierPhone.isHidden = false
            self.btnLoginWithEmail.isHidden = true
            self.btnSupplierEmail.isHidden = true
            self.btnFlag?.sd_setImage(with: URL(string: APIs().indianFlag), for: .normal, completed: nil)
            self.btnContryCode.setTitle("+91", for: .normal)

            
        }
    }
    
}


extension LoginVC : CountryInfoDelegate {
    func didcountryCodeAndName(countryID: Int,countryCode: String, countryName: String, countryFlag: String) {
        self.btnFlag?.sd_setImage(with: URL(string: countryFlag), for: .normal, completed: nil)
        self.btnContryCode.setTitle(countryCode, for: .normal)
        
    }
    
    
}
