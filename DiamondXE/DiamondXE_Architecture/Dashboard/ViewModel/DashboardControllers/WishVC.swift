//
//  WishVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 16/05/24.
//

import UIKit

class WishVC: UIViewController, ChildViewControllerProtocol {
    
    func didSendString(str: String) {
        print(str)
    }
    
    var delegate : BaseViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
