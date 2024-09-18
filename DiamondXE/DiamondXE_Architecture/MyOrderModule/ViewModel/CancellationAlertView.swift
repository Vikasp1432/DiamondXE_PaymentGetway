//
//  CancellationAlertView.swift
//  DiamondXE
//
//  Created by iOS Developer on 18/09/24.
//

import UIKit
import DTTextField
import DropDown

class CancellationAlertView: UIViewController , UITextViewDelegate{

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: UIButton) {
        hide()
    }
    
    @IBOutlet var selectResionView : UIView!
    @IBOutlet var txtselectResion : DTTextField!
  
    @IBOutlet weak var btnWallet: UIButton!
    @IBOutlet weak var btnPaymentMode: UIButton!
    @IBOutlet weak var btnProcesses: UIButton!
    @IBOutlet weak var textView: UITextView!

    var isWallet = true
    var isPaymntMode = false
    
    let placeholderText = "Enter your resion here..."
  
    
    init() {
        super.init(nibName: "CancellationAlertView", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        txtselectResion.isUserInteractionEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        selectResionView.addGestureRecognizer(tap)
        setupTextView()
        
        self.btnProcesses.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])

        
    }
    
    func setupTextView() {
           textView.delegate = self
           textView.text = placeholderText
           textView.textColor = UIColor.lightGray
       }
       
       // UITextViewDelegate method to clear the placeholder when the user starts editing
       func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.text == placeholderText {
               textView.text = ""
               textView.textColor = UIColor.black // Set text color to black
           }
       }
       
       // UITextViewDelegate method to show placeholder when the user leaves the text view empty
       func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text.isEmpty {
               textView.text = placeholderText
               textView.textColor = UIColor.lightGray // Set text color to light gray
           }
       }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        openDropDown()
        
    }
    
    
    func openDropDown(){
       var dropDown = DropDown()
        dropDown.anchorView = self.selectResionView
        dropDown.dataSource = ["Resion 1","Resion 2","Resion 3","Resion 4","Resion 5"]
        dropDown.backgroundColor = UIColor.whitClr
        dropDown.selectionBackgroundColor = UIColor.themeClr.withAlphaComponent(0.2)
        dropDown.shadowColor = UIColor(white: 0.6, alpha: 1)
        dropDown.shadowOpacity = 0.7
        dropDown.shadowRadius = 15
        dropDown.cellHeight = 40
        dropDown.height = 250
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
       

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtselectResion.text = item
            dropDown.hide()

        }
        dropDown.show()
    }

   
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController, tag:Int) {

            sender.present(self, animated: false) {
                self.show()
                
        }
    }
    
    
  
    
    
    private func show() {
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    @IBAction func btnactionsCancleTypeAndProcessed(_ sender : UIButton){
        
        if sender.tag == 0{
            isWallet = true
            self.isPaymntMode = false
            self.btnWallet.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            self.btnPaymentMode.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
           // self.btnActionsCancel(selectedItemsArray)
        }
        else if sender.tag == 1{
            isWallet = false
            self.isPaymntMode = true
            self.btnWallet.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
            self.btnPaymentMode.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            
        }
        else if sender.tag == 2{
            hide()
        }
        else if sender.tag == 3{
            hide()
        }
        
      
       
    }
}
   

