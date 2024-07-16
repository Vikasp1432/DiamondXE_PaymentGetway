//
//  Supplier_CompanyDetails.swift
//  DiamondXE
//
//  Created by iOS Developer on 11/05/24.
//

import UIKit
import DTTextField

class Supplier_CompanyDetails: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet  var btnDropDown:UIButton!
    
    @IBOutlet var btnFlag: UIButton!
    @IBOutlet var btnCode: UIButton!
//    @IBOutlet var btnVerifyGst: UIButton!
//    @IBOutlet var btnVerifyDonegGst: UIButton!
//    @IBOutlet  var btnInventoryType:UIButton!
//    @IBOutlet var btnGSTDocIcon: UIButton!
//    @IBOutlet var btnPANDocIcon: UIButton!
//    @IBOutlet var btnTradeDocIcon: UIButton!
//    @IBOutlet var btnIECDocIcon: UIButton!
//    
//    @IBOutlet var btnVerifyPan: UIButton!
//    @IBOutlet var btnVerifyDonegPan: UIButton!
//    
//    @IBOutlet var btnVerifyEmail: UIButton!
//    @IBOutlet var btnVerifyDonegEmail: UIButton!
    
    @IBOutlet var txtCity:DTTextField!
    @IBOutlet var txtState:DTTextField!
    @IBOutlet var txtCountry:DTTextField!
//    @IBOutlet var txtGST:DTTextField!
//    @IBOutlet var txtPAN:DTTextField!
  
    @IBOutlet var txtMobile:DTTextField!
    @IBOutlet var txtEmail:DTTextField!
    @IBOutlet var txtCompanyName:DTTextField!
    @IBOutlet var txtAddress1:DTTextField!
    @IBOutlet var txtAddress2:DTTextField!
//    @IBOutlet var txtCompanyType:DTTextField!
//    @IBOutlet var txtBusinessVal:DTTextField!
//    @IBOutlet var txtTradeNumber:DTTextField!
//    @IBOutlet var txtIEXNumber:DTTextField!
    @IBOutlet var txtIPinNum:DTTextField!
    
    @IBOutlet var txtPassword:DTTextField!
    @IBOutlet var txtConfirmPassword:DTTextField!
    @IBOutlet var txtInventoryType:DTTextField!
    @IBOutlet var btnCompanyType:UIButton!
//    @IBOutlet var btnBusinessNature:UIButton!
    
    @IBOutlet var viewBG:UIView!
    
    var buttonPressed : ((Int) -> Void) = {_ in }
    
    var buttonDocBase64 : ((Int) -> Void) = {_ in }
    var buttonVerify : ((Int) -> Void) = {_ in }
    var buttonBottomSheet : ((Int) -> Void) = {_ in }
    var buttonDropDownCB : ((Int) -> Void) = {_ in }
    
    var cellDataDelegate : CellDataDelegate?
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.3
        viewBG.layer.masksToBounds = false
        
        
        txtPassword.isSecureTextEntry = true
        txtConfirmPassword.isSecureTextEntry = true
        txtMobile.paddingX = 110

        
//        txtGST.delegate = self
//        txtPAN.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        txtInventoryType.delegate = self
//        self.btnFlag.setTitle(APIs().indianFlag, for: .normal)
        BaseViewController.setClrUItextField2(textFields: [txtCity, txtState, txtCountry, txtMobile, txtEmail, txtAddress1, txtAddress2, txtCompanyName, txtIPinNum, txtPassword, txtConfirmPassword, txtInventoryType])
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // Check which text field triggered the method
//           if textField == txtGST {
//               self.btnVerifyGst.isHidden = false
//               self.btnVerifyDonegGst.isHidden = true
//           } else if textField == txtPAN {
//               self.btnVerifyPan.isHidden = false
//               self.btnVerifyDonegPan.isHidden = true
//           }
//        else  if textField == txtEmail {
//            self.btnVerifyEmail.isHidden = false
//            self.btnVerifyDonegEmail.isHidden = true
//        }
        if let dtTextField = textField as? DTTextField {
            dtTextField.borderColor = UIColor.tabSelectClr
        }
           return true
       }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
        }
        
//      if let text = txtGST.text {
//       
//          cellDataDelegate?.didUpdateText(textKey: "CO.GST", text: text, indexPath: indexPath)
//          
//      }
//        if let text = txtPAN.text {
//            cellDataDelegate?.didUpdateText(textKey: "CO.PAN", text: text, indexPath: indexPath)
//        }
        
        if let text = txtCompanyName.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.Name", text: text, indexPath: indexPath)
        }
        if let text = txtMobile.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.Mobile", text: text, indexPath: indexPath)
        }
        if let text = txtEmail.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.Email", text: text, indexPath: indexPath)
        }
        if let text = txtPassword.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.Pass", text: text, indexPath: indexPath)
        }
        if let text = txtConfirmPassword.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.CnfPass", text: text, indexPath: indexPath)
        }
        if let text = txtInventoryType.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.Inventory", text: text, indexPath: indexPath)
        }
        if let text = txtCountry.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.Country", text: text, indexPath: indexPath)
        }
        if let text = txtState.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.State", text: text, indexPath: indexPath)
        }
        if let text = txtCity.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.City", text: text, indexPath: indexPath)
        }
        if let text = txtIPinNum.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.PinC", text: text, indexPath: indexPath)
        }
        if let text = txtAddress1.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.Add1", text: text, indexPath: indexPath)
        }
        if let text = txtAddress2.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.Add2", text: text, indexPath: indexPath)
        }
//        if let text = txtTradeNumber.text {
//            cellDataDelegate?.didUpdateText(textKey: "CO.TradeN", text: text, indexPath: indexPath)
//        }
//        if let text = txtIEXNumber.text {
//            cellDataDelegate?.didUpdateText(textKey: "CO.IECN", text: text, indexPath: indexPath)
//        }
        if let text = txtCompanyName.text {
            cellDataDelegate?.didUpdateText(textKey: "CO.ComType", text: text, indexPath: indexPath)
        }
//        if let text = txtBusinessVal.text {
//            cellDataDelegate?.didUpdateText(textKey: "CO.BusinessNature", text: text, indexPath: indexPath)
//        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           // Change border color or perform any other actions
           if let customTextField = textField as? DTTextField {
               customTextField.borderColor = UIColor.tabSelectClr
           }
       }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupData(isExpand:Bool){
        if isExpand{
            viewBGData.isHidden = true
            btnDropDown.setImage( UIImage(named: "d_down"), for: .normal)

        }
        else{
            viewBGData.isHidden = false
            btnDropDown.setImage(UIImage(named: "d_up"), for: .normal)
            
        }
    }

    
    @IBAction func buttonAction(_ sender: UIButton) {
        buttonPressed(sender.tag)
    }
    
    @IBAction func buttonActionVerifyDoc(_ sender: UIButton) {

        buttonVerify(sender.tag)
    }
    
    @IBAction func buttonActionDocBase64(_ sender: UIButton) {

        buttonDocBase64(sender.tag)
    }
    
    
    @IBAction func buttonActionBottomsheetList(_ sender: UIButton) {

        buttonBottomSheet(sender.tag)
    }
    
    @IBAction func buttonActionDropdown(_ sender: UIButton) {

        buttonDropDownCB(sender.tag)
    }
    
}
