//
//  DashboardVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/04/24.
//

import UIKit




class DashboardVC: BaseViewController, BaseViewControllerDelegate {
   
 
    @IBOutlet var containerViewSideMenu: UIView!
    @IBOutlet var viewBG: UIImageView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var menuTableView: UITableView!
    @IBOutlet var lblVersion: UILabel!
    
    @IBOutlet var imgLOGO: UIImageView!
    @IBOutlet var stackIcons: UIStackView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var headerView: UIView!
    
    
    let screen = UIScreen.main.bounds
    var menu = false
    var home = CGAffineTransform()
    var diamondDetails = DiamondListingDetail()
    
    
    @IBOutlet var viewTabBar:UIView!
    @IBOutlet var btnSearch:UIButton!
    
    @IBOutlet var btnHome: UIButton!
    @IBOutlet var btnCategory: UIButton!
    @IBOutlet var btnWish: UIButton!
    @IBOutlet var btnCart: UIButton!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnTitleHome: UIButton!
    @IBOutlet var btnTitleCategory: UIButton!
    @IBOutlet var btnTitleWish: UIButton!
    @IBOutlet var btnTitleCart: UIButton!
    @IBOutlet var btnTitleLogin: UIButton!
    @IBOutlet var btnSideMenu : UIButton!
    @IBOutlet var viewSideMnu : UIView!

    @IBOutlet weak var containerView: UIView!
    var tagV = VCTags()
    
    
    private var currentViewController: UIViewController?
    private var currentViewControllerIdentifier: String?
    var sideMenuBtnTag = 0
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
           let location = sender.location(in: view)
           print("Screen tapped at: \(location)")
       }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        viewSideMnu.addGestureRecognizer(tapGesture)
//        btnSideMenu.isUserInteractionEnabled = true
//        btnSideMenu.superview?.isUserInteractionEnabled = true

        let navigationController = UINavigationController(rootViewController: self)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        
        self.lblVersion.text = getAppVersion
        btnSearch.layer.shadowOffset = CGSize(width:0, height:0)
        btnSearch.layer.shadowRadius = 2.5
        btnSearch.layer.shadowColor = UIColor.black.cgColor
        btnSearch.layer.shadowOpacity = 0.5
        btnSearch.clipsToBounds = false
        btnSearch.superview?.clipsToBounds = false
        
      
        loadViewController(withIdentifier: viewControllerIdentifiers[0], fromStoryboard: storyboardNames[0])
        
        self.lblTitle.isHidden = true
        home = self.containerView.transform
        
        // define uitableview cell
        menuTableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        menuTableView.register(UINib(nibName: MainCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier)
        menuTableView.showsHorizontalScrollIndicator = false
        menuTableView.showsVerticalScrollIndicator = false

    }
    
    func updateHeaderBG(setUpTag:Int) {
        if setUpTag == 0 {
            headerView.backgroundColor = .whitClr
            headerView.layer.shadowColor = UIColor.lightGray.cgColor
            headerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
            headerView.layer.shadowRadius = 1.0
            headerView.layer.shadowOpacity = 0.3
            headerView.layer.masksToBounds = false
        }
        else{
            headerView.backgroundColor = .videBGClr
            headerView.layer.shadowColor = UIColor.shadowViewclr.cgColor
            headerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            headerView.layer.shadowRadius = 0.0
            headerView.layer.shadowOpacity = 0.0
            headerView.layer.masksToBounds = false
        }
    }

    //goto search from dashboard
    func didPerformAction(tag: Int) {
        switch tag {
        case 0:
            updateHeaderBG(setUpTag: 1)
            self.gotoSearchDiamondVC(title: "Solitaires")
        default:
            print(tag)
        }
       
       }
    
    func loadViewController(withIdentifier identifier: String, fromStoryboard storyboardName: String) {
            if identifier == currentViewControllerIdentifier {
                return
            }

            let direction: SlideDirection = {
                if let currentIdentifier = currentViewControllerIdentifier,
                   let currentIndex = viewControllerIdentifiers.firstIndex(of: currentIdentifier),
                   let newIndex = viewControllerIdentifiers.firstIndex(of: identifier) {
                    return newIndex > currentIndex ? .right : .left
                }
                return .right
            }()

            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            guard let newViewController = storyboard.instantiateViewController(withIdentifier: identifier) as? ChildViewControllerProtocol else { return }
        
          if let diamondDetailsVC = newViewController as? DiamondDetailsVC {
              diamondDetailsVC.diamondInfo = self.diamondDetails
            }
        
        if let b2bSearchDiamondVC = newViewController as? B2BSearchResultVC {
               b2bSearchDiamondVC.dashboardVC = self
           }
            
             newViewController.delegate = self
            newViewController.didSendString(str: self.lblTitle.text ?? "")
            let width = self.containerView.bounds.size.width
            let initialFrame = CGRect(x: direction == .right ? width : -width, y: 0, width: width, height: self.containerView.bounds.size.height)
            let finalFrame = self.containerView.bounds

            newViewController.view.frame = initialFrame
            containerView.addSubview(newViewController.view)
            addChild(newViewController)
            newViewController.didMove(toParent: self)
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                newViewController.view.frame = finalFrame
                self.currentViewController?.view.frame = CGRect(x: direction == .right ? -width : width, y: 0, width: width, height: self.containerView.bounds.size.height)
            }) { _ in
                self.currentViewController?.willMove(toParent: nil)
                self.currentViewController?.view.removeFromSuperview()
                self.currentViewController?.removeFromParent()
                self.currentViewController = newViewController
                self.currentViewControllerIdentifier = identifier
            }
        
    }
    
    
    
    
//     func loadViewController(withIdentifier identifier: String, fromStoryboard storyboardName: String) {
//        
//        // Check if the new view controller is the same as the current one
//        if identifier == currentViewControllerIdentifier {
//            return
//        }
//
//        // Determine the direction
//        let direction: SlideDirection = {
//            if let currentIdentifier = currentViewControllerIdentifier,
//               let currentIndex = viewControllerIdentifiers.firstIndex(of: currentIdentifier),
//               let newIndex = viewControllerIdentifiers.firstIndex(of: identifier) {
//                return newIndex > currentIndex ? .right : .left
//            }
//            return .right
//        }()
//
//        // Instantiate the view controller
//        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
//         let newViewController = storyboard.instantiateViewController(withIdentifier: identifier)
//         newViewController.delegate = self
//
//       
//         let width = self.containerView.bounds.size.width
//         let initialFrame = CGRect(x: direction == .right ? width : -width, y: 0, width: width, height: self.containerView.bounds.size.height)
//         let finalFrame = self.containerView.bounds
//
//        newViewController.view.frame = initialFrame
//        containerView.addSubview(newViewController.view)
//        addChild(newViewController)
//        newViewController.didMove(toParent: self)
//        
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
//            newViewController.view.frame = finalFrame
//            self.currentViewController?.view.frame = CGRect(x: direction == .right ? -width : width, y: 0, width: width, height: self.containerView.bounds.size.height)
//        }) { _ in
//            self.currentViewController?.willMove(toParent: nil)
//            self.currentViewController?.view.removeFromSuperview()
//            self.currentViewController?.removeFromParent()
//            self.currentViewController = newViewController
//           
//            self.currentViewControllerIdentifier = identifier
//        }
//    }

    
    
    
    func showMenu() {
        containerViewSideMenu.layer.shadowOffset = CGSize(width:0, height:0)
        containerViewSideMenu.layer.shadowRadius = 4.5
        containerViewSideMenu.layer.shadowColor = UIColor.gray.cgColor
        containerViewSideMenu.layer.shadowOpacity = 0.6
        self.containerViewSideMenu.layer.cornerRadius = 2
        self.viewBG.layer.cornerRadius = self.containerViewSideMenu.layer.cornerRadius
        let x = screen.width * 0.8
        let originalTransform = self.containerViewSideMenu.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.containerViewSideMenu.transform = scaledAndTranslatedTransform
                
            })
        
    }
    
    func hideMenu() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.containerViewSideMenu.transform = self.home
            self.containerViewSideMenu.layer.cornerRadius = 0
            self.viewBG.layer.cornerRadius = 0
            
        })
        
    }
    
//    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
//        if menu == false && swipeGesture.direction == .right {
//            
//            print("showing menu")
//            
//            showMenu()
//            
//            menu = true
//            
//        }
//    }
    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        
       // print("menu interaction")
        if self.sideMenuBtnTag == 0{
            if menu == false && swipeGesture.direction == .right {
                
                //print("user is showing menu")
                
                showMenu()
                
                menu = true
                
            }
           
        }
        
    }
    
    
    
    @IBAction func hideMenu(_ sender: Any) {
        
        if menu == true {
            
          //  print("user is hiding menu")
            
            hideMenu()
            
            menu = false
            
        }
        
        
    }
    
    
    @IBAction func btnActionTapped(_ sender: UIButton) {
        let identifier = viewControllerIdentifiers[sender.tag]
        let storyboardName = storyboardNames[sender.tag]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        self.sideMenuBtnTag = 0
        updateHeaderBG(setUpTag: 1)
        self.btnSideMenu.setImage(UIImage(named: "sideMenu"), for: .normal)
        self.lblTitle.isHidden = true
        self.imgLOGO.isHidden = false
        self.stackIcons.isHidden = false
        switch sender.tag {
        case 0:
            self.btnHome.tintColor = .themeClr
            self.btnCategory.tintColor = .clrGray
            self.btnWish.tintColor = .clrGray
            self.btnCart.tintColor = .clrGray
            self.btnLogin.tintColor = .clrGray
            self.btnTitleHome.setTitleColor(UIColor.themeClr, for: .normal)
            self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
            
        case 1:
            self.btnHome.tintColor = .clrGray
            self.btnCategory.tintColor = .themeClr
            self.btnWish.tintColor = .clrGray
            self.btnCart.tintColor = .clrGray
            self.btnLogin.tintColor = .clrGray
            self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCategory.setTitleColor(UIColor.themeClr, for: .normal)
            self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
            
        case 2:
            self.btnHome.tintColor = .clrGray
            self.btnCategory.tintColor = .clrGray
            self.btnWish.tintColor = .themeClr
            self.btnCart.tintColor = .clrGray
            self.btnLogin.tintColor = .clrGray
            self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleWish.setTitleColor(UIColor.themeClr, for: .normal)
            self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
           
        case 3:
            self.btnHome.tintColor = .clrGray
            self.btnCategory.tintColor = .clrGray
            self.btnWish.tintColor = .clrGray
            self.btnCart.tintColor = .themeClr
            self.btnLogin.tintColor = .clrGray
            self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCart.setTitleColor(UIColor.themeClr, for: .normal)
            self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
            
        default:
            self.btnHome.tintColor = .clrGray
            self.btnCategory.tintColor = .clrGray
            self.btnWish.tintColor = .clrGray
            self.btnCart.tintColor = .clrGray
            self.btnLogin.tintColor = .themeClr
            self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleLogin.setTitleColor(UIColor.themeClr, for: .normal)
            
        }
    }
   
    
    @IBAction func btnActionSideMenu(_ sender: UIButton) {
       // print("menu interaction")
        
        switch self.currentViewController {
        case is B2BSearchResultVC:
            updateHeaderBG(setUpTag: 1)
            gotoSearchDiamondVC(title: "Search Diamond")
            
        case is DiamondDetailsVC:
            updateHeaderBG(setUpTag: 1)
            gotoSearchResultB2BVC(title: "Search Diamond")
            
        default:
            updateHeaderBG(setUpTag: 1)
            if self.sideMenuBtnTag == 0{
                
                if menu == false && swipeGesture.direction == .right {
                    
                    //print("user is showing menu")
                    
                    showMenu()
                    
                    menu = true
                    
                }
                else{
                    hideMenu()
                    menu = false
                }
            }
            else{
                self.sideMenuBtnTag = 0
                self.homeMenuActive()
                self.btnSideMenu.setImage(UIImage(named: "sideMenu"), for: .normal)
                self.lblTitle.isHidden = true
                self.imgLOGO.isHidden = false
                self.stackIcons.isHidden = false
            }
        }
    }
    
    
    
  
    
    @IBAction func btnActionSearch(_ sender: UIButton) {
        
        switch self.currentViewController {
        case is SearchDiamondVC:
            updateHeaderBG(setUpTag: 0)
           gotoSearchResultB2BVC(title: "Search Result")
        default:
            print(self.currentViewController)
        }
        
//     navigationManager(storybordName: "GlobleSearch", storyboardID: "GlobleSearchVC", controller: GlobleSearchVC())
    }
    
    @IBAction func btnActionSocialM(_ sender: UIButton) {
        self.tagV.tagVC = sender.tag
        gotoWKWebView()
        
    }

    
}


extension DashboardVC : B2BSearchResultVCDelegate {
    func didSelectDiamond(_ diamond: DiamondListingDetail) {
        print(diamond)
        self.diamondDetails = diamond
//        let identifier = viewControllerIdentifiers[0]
//        let storyboardName = storyboardNames[0]
//        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        self.loadViewController(withIdentifier: "DiamondDetailsVC", fromStoryboard: "DiamondDetails")

    }
    
}

extension DashboardVC:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let section = sections[section]
            if section.isExpandableCellsHidden {
                return 1
            } else {
                return section.expandableCellOptions.count + 1
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellIdentifier, for: indexPath) as! MainCell
                cell.configure(with: sections[indexPath.section])
                cell.mainIconIMG.image = sections[indexPath.section].mainCellOptionsIcons[indexPath.section]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.cellIdentifier, for: indexPath) as! ExpandableCell
                cell.label.text = sections[indexPath.section].expandableCellOptions[indexPath.row - 1]
                cell.iconIMG.image = sections[indexPath.section].expandableCellOptionsIcons[indexPath.row - 1]
                return cell
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                let section = indexPath.section
                
                self.sideMenuActions(sectionStr: sections[section].mainCellTitle)
                
                let isCurrentlyHidden = sections[section].isExpandableCellsHidden
                sections[section].isExpandableCellsHidden = !isCurrentlyHidden
                sections[section].isExpanded = !isCurrentlyHidden // Update the expanded state

                if sections[section].expandableCellOptions.isEmpty {
                    // If there are no expandable options, do nothing
                    return
                }

                var indexPaths = [IndexPath]()
                for row in 1...sections[section].expandableCellOptions.count {
                    indexPaths.append(IndexPath(row: row, section: section))
                }
                
                tableView.beginUpdates()
                if isCurrentlyHidden {
                    // Expand the section with animation
                    tableView.insertRows(at: indexPaths, with: .fade)
                } else {
                    // Collapse the section with animation
                    tableView.deleteRows(at: indexPaths, with: .fade)
                }
                tableView.endUpdates()

                // Reload the main cell to update the icon
                let mainCellIndexPath = IndexPath(row: 0, section: section)
                tableView.reloadRows(at: [mainCellIndexPath], with: .none)
            }
            
            else{
                self.sideMenuActions(sectionStr: sections[indexPath.section].expandableCellOptions[indexPath.row - 1])
            }
        }
    
    
    func homeMenuActive(){
        let identifier = viewControllerIdentifiers[0]
        let storyboardName = storyboardNames[0]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        self.btnHome.tintColor = .themeClr
        self.btnCategory.tintColor = .clrGray
        self.btnWish.tintColor = .clrGray
        self.btnCart.tintColor = .clrGray
        self.btnLogin.tintColor = .clrGray
        self.btnTitleHome.setTitleColor(UIColor.themeClr, for: .normal)
        self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
        hideMenu()
        menu = false
    }
    
    func sideMenuActions(sectionStr:String){
        
        if nv_home == sectionStr{
            if menu == true {
                homeMenuActive()
            }
        }
        
        else if nv_naturalDiamond == sectionStr{
            updateHeaderBG(setUpTag: 1)
            gotoSearchDiamondVC(title: "Natural Diamonds")
//            print(sectionStr)
//          //  self.navigationManager(storybordName: "SearchDiamond", storyboardID: "SearchDiamondVC", controller: SearchDiamondVC())
//            let identifier = viewControllerIdentifiers[5]
//            let storyboardName = storyboardNames[5]
//            loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
//            hideMenu()
//            menu = false
//            self.sideMenuBtnTag = 1
//            self.btnSideMenu.setImage(UIImage(named: "backButton"), for: .normal)
//            
//            self.lblTitle.isHidden = false
//            self.imgLOGO.isHidden = true
//            self.stackIcons.isHidden = true
//            
//            self.btnHome.tintColor = .clrGray
//            self.btnCategory.tintColor = .clrGray
//            self.btnWish.tintColor = .clrGray
//            self.btnCart.tintColor = .clrGray
//            self.btnLogin.tintColor = .clrGray
//            self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
//            self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
//            self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
//            self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
//            self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
            
        }
        
        else if nv_labGrownDiamond == sectionStr{
            updateHeaderBG(setUpTag: 1)
            gotoSearchDiamondVC(title: "Lab Grown Diamonds")
        }
        
        
        else if nv_diamondEducation == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 1
            gotoWKWebView()
           
        }
        
        else if nv_jeweller == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 2
            gotoWKWebView()
            
        }
        
        else if nv_supplier == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 3
            gotoWKWebView()
           
        }
        
        else if nv_aboutUS == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 4
            gotoWKWebView()
            
        }
        
        else if nv_whyUS == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 5
            gotoWKWebView()
            
        }
        
        else if nv_blogs == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 6
            gotoWKWebView()
         
        }
        
        else if nv_mediaGalley == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 7
            gotoWKWebView()
           
        }
        
        else if nv_support == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 8
            gotoWKWebView()
            
        }
        
        else if nv_termCondition == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 9
            gotoWKWebView()
            
        }
        
        else if nv_privacyPolicy == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 10
            gotoWKWebView()
            
        }
        
        else if nv_rateUS == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 11
            gotoWKWebView()
        }
        
        else if nv_emial == sectionStr{
            print(sectionStr)
            let email = sectionStr
                   if let emailURL = URL(string: "mailto:\(email)") {
                       if UIApplication.shared.canOpenURL(emailURL) {
                           UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
                       } else {
                           // Handle the error
                           print("Cannot open email client")
                       }
                   }
        }
        
        else if nv_whatsapp == sectionStr{
            print(sectionStr)
            let phoneNumber = sectionStr
                   if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                       if UIApplication.shared.canOpenURL(phoneURL) {
                           UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                       } else {
                           // Handle the error
                           print("Cannot open phone dialer")
                       }
                   }
        }
       
        
        
    }
    
    func gotoWKWebView(){
        self.navigationManager(WKWebViewVC.self, storyboardName: "Dashboard", storyboardID: "WKWebViewVC", data: self.tagV)
    }
    
    
    // goto outher vc manage bottom button color
    func manageBottomTag(){
        self.btnHome.tintColor = .clrGray
        self.btnCategory.tintColor = .clrGray
        self.btnWish.tintColor = .clrGray
        self.btnCart.tintColor = .clrGray
        self.btnLogin.tintColor = .clrGray
        self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
    }
    
    
    func gotoSearchDiamondVC(title:String){
        self.lblTitle.text = title
        let identifier = viewControllerIdentifiers[5]
        let storyboardName = storyboardNames[5]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        hideMenu()
        menu = false
        self.sideMenuBtnTag = 1
        self.btnSideMenu.setImage(UIImage(named: "backButton"), for: .normal)
        
        self.lblTitle.isHidden = false
        self.imgLOGO.isHidden = true
        self.stackIcons.isHidden = true
        
        manageBottomTag()
    }
    
    func gotoSearchResultB2BVC(title:String){
        self.lblTitle.text = title
        let identifier = viewControllerIdentifiers[6]
        let storyboardName = storyboardNames[6]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        hideMenu()
        menu = false
        self.sideMenuBtnTag = 1
        self.btnSideMenu.setImage(UIImage(named: "backButton"), for: .normal)
        
        self.lblTitle.isHidden = false
        self.imgLOGO.isHidden = true
        self.stackIcons.isHidden = true
        
        manageBottomTag()
    }
    
//    func gotoSearchResultB2BVC(title:String){
//        self.lblTitle.text = title
//        let identifier = viewControllerIdentifiers[6]
//        let storyboardName = storyboardNames[6]
//        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
//        hideMenu()
//        menu = false
//        self.sideMenuBtnTag = 1
//        self.btnSideMenu.setImage(UIImage(named: "backButton"), for: .normal)
//        
//        self.lblTitle.isHidden = false
//        self.imgLOGO.isHidden = true
//        self.stackIcons.isHidden = true
//        
//        manageBottomTag()
//    }
    
}
