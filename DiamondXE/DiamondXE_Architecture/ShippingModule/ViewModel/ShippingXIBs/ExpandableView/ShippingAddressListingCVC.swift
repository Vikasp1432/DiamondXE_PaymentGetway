//
//  ShippingAddressListingCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/08/24.
//

import UIKit

class ShippingAddressListingCVC: UICollectionViewCell {
    
    static let cellIdentifierShippingAddressListingCVC = String(describing: ShippingAddressListingCVC.self)
    
    
    @IBOutlet var viewNoData:UIView!
    @IBOutlet var viewData:UIView!
    
    @IBOutlet var lblName:UILabel!
    @IBOutlet var lblAddress:UILabel!
    @IBOutlet var lblPhone:UILabel!
    @IBOutlet var lblEmail:UILabel!
    @IBOutlet var lblAddressType:UILabel!
    
    @IBOutlet var btnEdit:UIButton!
    @IBOutlet var btnRadioSelect:UIButton!
    
    @IBOutlet var lblDefaut:UILabel!
    
    var btnActionCell : ((Int) -> Void) = {_ in }
    
    var isSelectedCell: Bool = false {
            didSet {
                updateRadioButton()
            }
        }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //viewData.addTopShadow()
        viewData.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewData.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewData.layer.shadowRadius = 2.0
        viewData.layer.shadowOpacity = 0.5
        viewData.layer.masksToBounds = false
        
        roundSpecificCorners(label: self.lblDefaut, corners: [.topLeft, .bottomRight], radius: 10)

    }
    
    
    func roundSpecificCorners(label: UILabel, corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: label.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        label.layer.mask = mask
    }

    
     func updateRadioButton() {
           let imageName = isSelectedCell ? "radioButtonSelected" : "radioButtonDeselected"
           btnRadioSelect.setImage(UIImage(named: imageName), for: .normal)
       }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    @IBAction func btnActionS(_ sender : UIButton){
        btnActionCell(sender.tag)
    }

}