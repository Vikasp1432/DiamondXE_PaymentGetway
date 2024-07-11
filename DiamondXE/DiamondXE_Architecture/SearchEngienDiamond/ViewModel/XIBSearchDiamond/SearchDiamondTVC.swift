//
//  SearchDiamondTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/05/24.
//

import UIKit

class SearchDiamondTVC: UITableViewCell, UITextFieldDelegate {

    static let cellIdentifierSearchDiamondTVC = String(describing: SearchDiamondTVC.self)

    @IBOutlet var collectionShap:UICollectionView!
    @IBOutlet var btnBest:UIButton!
    @IBOutlet var btnMedium:UIButton!
    @IBOutlet var btnLow:UIButton!
    @IBOutlet var btnNaturalDia:UIButton!
    @IBOutlet var btnLabGrownDia:UIButton!
    @IBOutlet var btnAdvanceFilter:UIButton!
    @IBOutlet var viewBGFilter:UIView!
    
    @IBOutlet var btnClorWhite:UIButton!
    @IBOutlet var btnClorFancy:UIButton!
    
    @IBOutlet var btnYes:UIButton!
    @IBOutlet var btnNo:UIButton!

    
    @IBOutlet var collectionColors:UICollectionView!
    @IBOutlet var collectionClarity:UICollectionView!
    @IBOutlet var collectionCertificate:UICollectionView!
    @IBOutlet var collectionFluorescence:UICollectionView!
    @IBOutlet var collectionMake:UICollectionView!
    
    @IBOutlet var viewNatBG:UIView!
    @IBOutlet var viewLabBG:UIView!
    
    @IBOutlet var txtPriceFrom:UITextField!
    @IBOutlet var txtCaratFrom:UITextField!
    @IBOutlet var txtPriceTo:UITextField!
    @IBOutlet var txtCaratTo:UITextField!
    
    var delegate : SearchOptionSelecteDelegate?
    
    
    var imgArr = [  UIImage(named:"all"),
                    UIImage(named:"round") ,
                    UIImage(named:"princess_") ,
                    UIImage(named:"emrald") ,
                    UIImage(named:"heart_") ,
                    UIImage(named:"radiant"),
                    UIImage(named:"oval"),
                    UIImage(named:"pear"),
                    UIImage(named:"marquise"),
                    UIImage(named:"asscher")]
    var shapeDataArr = ["All",
                    "Round" ,
                    "Princess" ,
                    "Emrald" ,
                    "Heart",
                    "Radiant",
                    "Oval",
                    "Pear",
                    "Marquise",
                    "Asscher"]
    
   
    var selectedIndicesShaps: Set<IndexPath> = []
    var selectedIndicesColor: Set<IndexPath> = []
    var selectedIndicesClarity: Set<IndexPath> = []
    var selectedIndicesCertificate: Set<IndexPath> = []
    var selectedIndicesFluorescence: Set<IndexPath> = []
    var selectedIndicesMake: IndexPath?
    
    var dataArrColorWhite : [SearchAttribDetail]?
    var dataArrColorFancy : [SearchAttribDetail]?
    var dataArrClarity: [SearchAttribDetail]?
    var dataArrCertificate: [SearchAttribDetail]?
    var dataArrFluorescence: [SearchAttribDetail]?
    var dataArrMake: [SearchAttribDetail]?
    
    
    var selectedDataArrColorWhite = [SearchAttribDetail]()
    var selectedDataArrColorFancy = [SearchAttribDetail]()
    var selectedDataArrClarity = [SearchAttribDetail]()
    var selectedDataArrCertificate = [SearchAttribDetail]()
    var selectedDataArrFluorescence = [SearchAttribDetail]()
    var selectedDataArrMake = [SearchAttribDetail]()
    var shapeArr = [String]()
    
    var textData = [SearchAttribDetail]()
    var diaQualityTap: [String]?
    
    var isBestQuality = false
    var isMediumQuality = false
    var isLowQuality = false
    
    var btnActionAdvanceFilter : (([SearchAttribDetail]) -> Void) = {_ in }

    
   // var searchAttributeStruct = SearchOptionDataStruct()
    var colorDiaWhiteShow = true


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        txtPriceFrom.delegate = self
        txtCaratFrom.delegate = self
        txtPriceTo.delegate = self
        txtCaratTo.delegate = self
     
        collectionShap.register(UINib(nibName: SearchDiamondCVC.cellIdentifierShapeDiamondCVC, bundle: nil), forCellWithReuseIdentifier: SearchDiamondCVC.cellIdentifierShapeDiamondCVC)
        
        collectionColors.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
        
        collectionClarity.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
        
        collectionCertificate.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
        
        collectionFluorescence.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
        
        collectionMake.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
      
        configureCollectionView(collectionShap)
        configureCollectionView(collectionColors)
        configureCollectionView(collectionClarity)
        configureCollectionView(collectionCertificate)
        configureCollectionView(collectionFluorescence)
        configureCollectionView(collectionMake)
        

        
        // filter datya
//        self.filterDataStruct()

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//           if let text = textField.tag {
        self.textData.removeAll()
        switch textField.tag {
        case 1:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "PriceFrom", details: self.textData, shapeArr: [])
        case 2:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "PriceTo", details: self.textData, shapeArr: [])
        case 3:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "CaratFrom", details: self.textData, shapeArr: [])
        case 4:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "CaratTo", details: self.textData, shapeArr: [])
       
        default:
            print(textField.text)
        }
//           }
       }
    
    
    func filterDataStruct(searchAttributeStruct:SearchOptionDataStruct){
        
        searchAttributeStruct.details?.forEach { attributeData in
            
            if attributeData.attribType == attributeTypeWhite{
                self.dataArrColorWhite = attributeData.attribDetails
                self.collectionColors.reloadData()
            }
            
            if attributeData.attribType == attributeTypeFancy{
                self.dataArrColorFancy = attributeData.attribDetails
                self.collectionColors.reloadData()
            }
            
            if attributeData.attribType == attributeTypeClarity{
                self.dataArrClarity = attributeData.attribDetails
                self.collectionClarity.reloadData()
            }
            
            if attributeData.attribType == attributeTypeCertificate{
                self.dataArrCertificate = attributeData.attribDetails
                self.collectionCertificate.reloadData()
            }
            
            if attributeData.attribType == attributeTypeFluorescence{
                self.dataArrFluorescence = attributeData.attribDetails
                self.collectionFluorescence.reloadData()
            }
            
            if attributeData.attribType == attributeTypeMake{
                self.dataArrMake = attributeData.attribDetails
                self.collectionMake.reloadData()
            }
            
        }
        
    }
    
    
    func configureCollectionView(_ collectionView: UICollectionView) {
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.showsVerticalScrollIndicator = false
           collectionView.allowsMultipleSelection = true
           collectionView.delegate = self
           collectionView.dataSource = self

           
//            self.btnBest.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//            self.btnBest.setTitleColor(.whitClr, for: .normal)
            self.viewBGFilter.setGradientLayerView(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        
       }
    
    func setGradientBtn(string:String){
        if string == "Lab Grown Diamonds"{
            self.btnLabGrownDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            self.btnLabGrownDia.setTitleColor(.whitClr, for: .normal)
            self.btnNaturalDia.clearGradient()
            self.btnNaturalDia.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.diaType = "labgrown"
            
        }
        else{
            self.btnNaturalDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            self.btnNaturalDia.setTitleColor(.whitClr, for: .normal)
            self.btnLabGrownDia.clearGradient()
            self.btnLabGrownDia.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.diaType = "natural"
        }
        
       
        DataManager.shared.color = "white"
        
    }
    
   
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionBestMediumLow(_ sender:UIButton){

        if sender.tag == 0{
            self.removedefaultFilter()
            self.isBestQuality.toggle()
            if self.isBestQuality{
                self.isMediumQuality = false
                self.isLowQuality = false
                btnBest.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                btnBest.setTitleColor(.whitClr, for: .normal)
                self.setupBtnLogicForDia( buttonTag: 0)
            }
            else{
                btnBest.clearGradient()
                btnBest.setTitleColor(.themeClr, for: .normal)
                
            }
          
            btnMedium.clearGradient()
            btnMedium.setTitleColor(.themeClr, for: .normal)
            btnLow.clearGradient()
            btnLow.setTitleColor(.themeClr, for: .normal)
            
        }
        else if sender.tag == 1{
            self.removedefaultFilter()
            self.isMediumQuality.toggle()
            if self.isMediumQuality{
                self.isBestQuality = false
                self.isLowQuality = false
                btnMedium.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                btnMedium.setTitleColor(.whitClr, for: .normal)
                self.setupBtnLogicForDia( buttonTag: 1)
            }
            else{
                
                btnMedium.clearGradient()
                btnMedium.setTitleColor(.themeClr, for: .normal)
               
            }
           
            btnBest.clearGradient()
            btnBest.setTitleColor(.themeClr, for: .normal)
            btnLow.clearGradient()
            btnLow.setTitleColor(.themeClr, for: .normal)
        }
        else {
            self.removedefaultFilter()
            self.isLowQuality.toggle()
            if self.isLowQuality{
                self.isMediumQuality = false
                self.isBestQuality = false
                btnLow.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                btnLow.setTitleColor(.whitClr, for: .normal)
                self.setupBtnLogicForDia( buttonTag: 2)
            }
            else{
                btnLow.clearGradient()
                btnLow.setTitleColor(.themeClr, for: .normal)
                
            }
           
           
            btnMedium.clearGradient()
            btnMedium.setTitleColor(.themeClr, for: .normal)
            btnBest.clearGradient()
            btnBest.setTitleColor(.themeClr, for: .normal)
        }
        
    }
    
    func setupBtnLogicForDia(buttonTag:Int){

            self.dataArrColorWhite?.enumerated().forEach { (index, detail) in
               
                switch buttonTag {
                case 0:
                    if index == 0 || index == 1 || index == 2 {
                        self.selectedDataArrColorWhite.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesColor.insert(indexPath)
                        
                    }
                    
                case 1:
                    if index == 3 || index == 4 || index == 5 {
                        self.selectedDataArrColorWhite.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesColor.insert(indexPath)
                    }
                    
                default:
                    if index == 6 || index == 7 || index == 8 {
                        self.selectedDataArrColorWhite.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesColor.insert(indexPath)
                        
                    }
                }
                delegate?.didselectOption(searchTitle: "Color", details: selectedDataArrColorWhite, shapeArr: [])
                self.collectionColors.reloadData()
            }
                
           
            self.dataArrClarity?.enumerated().forEach { (index, detail) in
                switch buttonTag {
                case 0:
                    if index == 0 || index == 1 || index == 2 || index == 3{
                        self.selectedDataArrClarity.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesClarity.insert(indexPath)
                    }
                case 1:
                    if index == 4 || index == 5{
                        self.selectedDataArrClarity.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesClarity.insert(indexPath)
                    }
                default:
                    if index == 6 || index == 7 || index == 8 || index == 9{
                        self.selectedDataArrClarity.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesClarity.insert(indexPath)
                    }
                }
                
                delegate?.didselectOption(searchTitle: "Clarity", details: selectedDataArrClarity, shapeArr: [])
                self.collectionClarity.reloadData()
            }
           
            self.dataArrCertificate?.enumerated().forEach { (index, detail) in
                switch buttonTag {
                case 0 ,1, 2:
                    if index == 0 || index == 1 {
                        self.selectedDataArrCertificate.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesCertificate.insert(indexPath)
                    }
               
                default:
                    print("Setificate")
                }
                delegate?.didselectOption(searchTitle: "Certificate", details: selectedDataArrCertificate, shapeArr: [])
                self.collectionCertificate.reloadData()
            }
            
            self.dataArrFluorescence?.enumerated().forEach { (index, detail) in
                
                switch buttonTag {
                case 0 :
                if index == 0{
                    self.selectedDataArrFluorescence.append(detail)
                    let itemIndex = index
                    let indexPath = IndexPath(item: itemIndex, section: 0)
                    selectedIndicesFluorescence.insert(indexPath)
                }
                case 1 :
                if index == 0 || index == 1 || index == 2{
                    self.selectedDataArrFluorescence.append(detail)
                    let itemIndex = index
                    let indexPath = IndexPath(item: itemIndex, section: 0)
                    selectedIndicesFluorescence.insert(indexPath)
                }
                default:

                        self.selectedDataArrFluorescence.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesFluorescence.insert(indexPath)
                }
                delegate?.didselectOption(searchTitle: "Fluorescence", details: selectedDataArrFluorescence, shapeArr: [])
                self.collectionFluorescence.reloadData()
            }
            
            self.dataArrMake?.enumerated().forEach { (index, detail) in
                switch buttonTag {
                case 0 :
                    if index == 0{
                        self.selectedDataArrMake.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesMake = indexPath
                    }
                case 1, 2 :
                    if index == 2{
                        self.selectedDataArrMake.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesMake = indexPath
                    }
                default:
                   print("Make")
                }
                
                delegate?.didselectOption(searchTitle: "Make", details: selectedDataArrMake, shapeArr: [])
                self.collectionMake.reloadData()
            }

    }
    
    func removedefaultFilter(){
        selectedIndicesShaps.removeAll()
        selectedIndicesColor.removeAll()
        selectedIndicesClarity.removeAll()
        selectedIndicesCertificate.removeAll()
        selectedIndicesFluorescence.removeAll()
        selectedDataArrColorWhite.removeAll()
        selectedDataArrColorFancy.removeAll()
        selectedDataArrClarity.removeAll()
        selectedDataArrCertificate.removeAll()
        selectedDataArrFluorescence.removeAll()
        selectedDataArrMake.removeAll()
        
        collectionColors.reloadData()
        collectionClarity.reloadData()
        collectionCertificate.reloadData()
        collectionFluorescence.reloadData()
        collectionMake.reloadData()
        
    }
    
    
    
    @IBAction func btnActionNaturalLabD(_ sender:UIButton){

        if sender.tag == 0{
            btnNaturalDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnNaturalDia.setTitleColor(.whitClr, for: .normal)
            btnLabGrownDia.clearGradient()
            btnLabGrownDia.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.diaType = "natural"
            
        }
        else{
            btnLabGrownDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//            viewLabBG.setGradientLayerView(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnLabGrownDia.setTitleColor(.whitClr, for: .normal)
            btnNaturalDia.clearGradient()
            btnNaturalDia.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.diaType = "labgrown"
        }
        
    }
    
    @IBAction func btnActionYES_No(_ sender:UIButton){

        if sender.tag == 0{
            btnYes.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnYes.setTitleColor(.whitClr, for: .normal)
            btnNo.clearGradient()
            btnNo.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.isReturnabl = 1
        }
        else{
            btnNo.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnNo.setTitleColor(.whitClr, for: .normal)
            btnYes.clearGradient()
            btnYes.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.isReturnabl = 0
        }
        
    }
    
    
    
    
    @IBAction func btnActioColor(_ sender:UIButton){
        if sender.tag == 0{
            colorDiaWhiteShow = true
            self.btnClorWhite.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            self.btnClorFancy.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)

            DataManager.shared.color = "white"
        }
        else{
            self.selectedDataArrColorWhite.removeAll()
            self.selectedIndicesColor.removeAll()
            colorDiaWhiteShow = false
            self.btnClorWhite.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
            self.btnClorFancy.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            DataManager.shared.color = "fancy"
        }
        self.collectionColors.reloadData()
    }
    
    @IBAction func btnActioAdvanceFilter(_ sender:UIButton){
        self.btnActionAdvanceFilter(selectedDataArrMake)
    }
    
}


extension SearchDiamondTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        switch collectionView {
        case self.collectionShap:
            return imgArr.count
        case self.collectionColors:
            if self.colorDiaWhiteShow{
                return self.dataArrColorWhite?.count ?? 0
            }
            else{
                return self.dataArrColorFancy?.count ?? 0
            }
            
//            return 10
        case self.collectionClarity:
            return self.dataArrClarity?.count ?? 0
            
        case self.collectionCertificate:
            return self.dataArrCertificate?.count ?? 0
            
        case self.collectionFluorescence:
            return self.dataArrFluorescence?.count ?? 0
            
        case self.collectionMake:
            return self.dataArrMake?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        switch collectionView {
        case self.collectionShap:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchDiamondCVC.cellIdentifierShapeDiamondCVC, for: indexPath) as! SearchDiamondCVC
            cell.lblCateIMG.image = imgArr[indexPath.row]
            cell.delegate = self
            cell.isShadowApplied = selectedIndicesShaps.contains(indexPath)
            return cell
        case self.collectionColors:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
            cell.delegate = self
            cell.isGradientApplied = selectedIndicesColor.contains(indexPath)
            
            if self.colorDiaWhiteShow{
                cell.btnTitle.setTitle(self.dataArrColorWhite?[indexPath.row].attribCode, for: .normal)
            }
            else{
                cell.btnTitle.setTitle(self.dataArrColorFancy?[indexPath.row].attribCode, for: .normal)
            }

            return cell
            
      
        case self.collectionClarity:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
            cell.delegate = self
            cell.isGradientApplied = selectedIndicesClarity.contains(indexPath)

            cell.btnTitle.setTitle(self.dataArrClarity?[indexPath.row].attribCode, for: .normal)
            return cell
            
        case self.collectionCertificate:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
            cell.delegate = self
            cell.isGradientApplied = selectedIndicesCertificate.contains(indexPath)
            cell.btnTitle.setTitle(self.dataArrCertificate?[indexPath.row].attribCode, for: .normal)
            return cell
            
        case self.collectionFluorescence:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
            cell.delegate = self
            cell.isGradientApplied = selectedIndicesFluorescence.contains(indexPath)
            cell.btnTitle.setTitle(self.dataArrFluorescence?[indexPath.row].displayAttr, for: .normal)
            return cell
            
        case self.collectionMake:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
            cell.delegate = self
            cell.isGradientApplied = selectedIndicesMake == indexPath
            cell.btnTitle.setTitle(self.dataArrMake?[indexPath.row].attribCode, for: .normal)
            return cell
            
        default:
           
            return UICollectionViewCell()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case self.collectionShap:
            let noOfCellsInRow = 4  //number of column you want
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size + 24  , height: size + 35)
        case self.collectionColors:
            if self.colorDiaWhiteShow{
                let noOfCellsInRow = 6 //number of column you want
                let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
                
                let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
                return CGSize(width: size  , height: size - 18)
            }
            else{
                
                    let noOfCellsInRow = 6 //number of column you want
                    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                    let totalSpace = flowLayout.sectionInset.left
                    + flowLayout.sectionInset.right
                    + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
                    
                    let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
                    return CGSize(width: size + 28 , height: size - 18)
                
            }
            
        case self.collectionFluorescence:
            
            let noOfCellsInRow = 6 //number of column you want
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size + 25 , height: size - 18)
        default:
            let noOfCellsInRow = 6 //number of column you want
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size + 15 , height: size - 18)
        }

        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        /*return 10*/ // Adjust the spacing between rows
//        
//        switch collectionView {
//        case self.collectionShap:
//            return 10
//            
//        default:
//            return 8
//        }
//    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            switch collectionView {
            case self.collectionShap:
                return 13

            default:
                return 13
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) // Adjust the left padding
        }
    

   
}


extension SearchDiamondTVC: CustomCollectionViewCellDelegate, OptionsCollectionViewCellDelegate{
    func btnTappedCell(in cell: SearchesOptionCVC) {
        if let indexPath = collectionColors.indexPath(for: cell) {
            if selectedIndicesColor.contains(indexPath) {
                selectedIndicesColor.remove(indexPath)
                if let selectData = dataArrColorWhite?[indexPath.row]{
                    self.selectedDataArrColorWhite.enumerated().forEach { index, item in
                        if selectData.attribID == item.attribID{
                            self.selectedDataArrColorWhite.remove(at: index)
                        }
                        
                    }
                }
                cell.isGradientApplied = false
            } else {
                selectedIndicesColor.insert(indexPath)
                if let selectData = dataArrColorWhite?[indexPath.row]{
                    self.selectedDataArrColorWhite.append(selectData)
                }
                cell.isGradientApplied = true
            }
            
            
            if self.selectedDataArrColorWhite.count > 0{
                self.delegate?.didselectOption(searchTitle: "Color", details: selectedDataArrColorWhite, shapeArr: [""])
            }
            if self.selectedDataArrColorFancy.count > 0{
                self.delegate?.didselectOption(searchTitle: "Color-Fancy", details: selectedDataArrColorFancy, shapeArr: [""])
            }
            
        }
        
        if let indexPath = collectionClarity.indexPath(for: cell) {
            if selectedIndicesClarity.contains(indexPath) {
                selectedIndicesClarity.remove(indexPath)
                
                if let selectData = dataArrClarity?[indexPath.row]{
                    self.selectedDataArrClarity.enumerated().forEach { index, item in
                        if selectData.attribID == item.attribID{
                            self.selectedDataArrClarity.remove(at: index)
                        }
                        
                    }
                    
                }
                
                cell.isGradientApplied = false
            } else {
                selectedIndicesClarity.insert(indexPath)
                if let selectData = dataArrClarity?[indexPath.row]{
                    self.selectedDataArrClarity.append(selectData)
                }
                cell.isGradientApplied = true
            }
            
            if self.selectedDataArrClarity.count > 0{
                self.delegate?.didselectOption(searchTitle: "Clarity", details: selectedDataArrClarity, shapeArr: [""])
            }
        }
        
        if let indexPath = collectionCertificate.indexPath(for: cell) {
            if selectedIndicesCertificate.contains(indexPath) {
                selectedIndicesCertificate.remove(indexPath)
                
                if let selectData = dataArrCertificate?[indexPath.row]{
                    self.selectedDataArrCertificate.enumerated().forEach { index, item in
                        if selectData.attribID == item.attribID{
                            self.selectedDataArrCertificate.remove(at: index)
                        }
                        
                    }
                    
                }
                
                cell.isGradientApplied = false
            } else {
                selectedIndicesCertificate.insert(indexPath)
                if let selectData = dataArrCertificate?[indexPath.row]{
                    self.selectedDataArrCertificate.append(selectData)
                }
                cell.isGradientApplied = true
            }
            if self.selectedDataArrCertificate.count > 0{
                self.delegate?.didselectOption(searchTitle: "Certificate", details: selectedDataArrCertificate, shapeArr: [""])
            }
        }
        
        if let indexPath = collectionFluorescence.indexPath(for: cell) {
            if selectedIndicesFluorescence.contains(indexPath) {
                selectedIndicesFluorescence.remove(indexPath)
                
                if let selectData = dataArrFluorescence?[indexPath.row]{
                    
                    self.selectedDataArrFluorescence.enumerated().forEach { index, item in
                        if selectData.attribID == item.attribID{
                            self.selectedDataArrFluorescence.remove(at: index)
                        }
                        
                    }
                    
                }
                
                cell.isGradientApplied = false
            } else {
                selectedIndicesFluorescence.insert(indexPath)
                if let selectData = dataArrFluorescence?[indexPath.row]{
                    self.selectedDataArrFluorescence.append(selectData)
                }
                cell.isGradientApplied = true
            }
            
            if self.selectedDataArrFluorescence.count > 0{
                self.delegate?.didselectOption(searchTitle: "Fluorescence", details: selectedDataArrFluorescence, shapeArr: [""])
            }
        }
        
        if let indexPath = collectionMake.indexPath(for: cell) {
            
            if selectedIndicesMake == indexPath {
                // Deselect the currently selected cell
                selectedIndicesMake = nil
                if let selectData = dataArrMake?[indexPath.row] {
                    selectedDataArrMake.removeAll { $0.attribID == selectData.attribID }
                }
                cell.isGradientApplied = false
                
            } else {
                // Deselect the previously selected cell
                if let previousIndex = selectedIndicesMake {
                    if let previousCell = collectionMake.cellForItem(at: previousIndex) as? SearchesOptionCVC {
                        previousCell.isGradientApplied = false
                    }
                    if let previousData = dataArrMake?[previousIndex.row] {
                        selectedDataArrMake.removeAll { $0.attribID == previousData.attribID }
                    }
                }
                
                // Select the new cell
                selectedIndicesMake = indexPath
                if let selectData = dataArrMake?[indexPath.row] {
                    selectedDataArrMake.append(selectData)
                }
                cell.isGradientApplied = true
            }
            
            // Notify the delegate
//            print(dataArrMake?.first?.attribID)
            if !selectedDataArrMake.isEmpty {
                delegate?.didselectOption(searchTitle: "Make", details: selectedDataArrMake, shapeArr: [""])
            }
            else{
                delegate?.didselectOption(searchTitle: "Make", details: [], shapeArr: [""])
            }
            
            
        }
    }
    
//    func imageViewTapped(in cell: SearchDiamondCVC) {
//        if let indexPath = collectionShap.indexPath(for: cell) {
//            if selectedIndicesShaps.contains(indexPath) {
//                selectedIndicesShaps.remove(indexPath)
//                self.shapeArr.enumerated().forEach { index, item in
//                    if item == shapeDataArr[indexPath.row]{
//                        self.shapeArr.remove(at: index)
//                    }
//                }
//                cell.isShadowApplied = false
//            } else {
//                selectedIndicesShaps.insert(indexPath)
//                self.shapeArr.append(shapeDataArr[indexPath.row])
//                cell.isShadowApplied = true
//                
////                if shapeDataArr[indexPath.row] == "All"{
////                    self.shapeDataArr.enumerated().forEach{ index,item in
////                        let idxPath = IndexPath(row: index, section: 0)
////                        selectedIndicesShaps.insert(idxPath)
////                        self.shapeArr.append(item)
////                        cell.isShadowApplied = true
////                    }
////                    
////                }
////                else{
////                    selectedIndicesShaps.insert(indexPath)
////                    self.shapeArr.append(shapeDataArr[indexPath.row])
////                    cell.isShadowApplied = true
////                }
//                    
//                
//            }
//            
//            if self.shapeArr.count > 0{
//                self.delegate?.didselectOption(searchTitle: "Shape", details: [], shapeArr: shapeArr)
//            }
//        }
//    }
    
    func imageViewTapped(in cell: SearchDiamondCVC) {
        if let indexPath = collectionShap.indexPath(for: cell) {
            let selectedItem = shapeDataArr[indexPath.row]
            
            // Handling the "All" selection
            if selectedItem == "All" {
                if selectedIndicesShaps.contains(indexPath) {
                    // Deselect all
                    selectedIndicesShaps.removeAll()
                    shapeArr.removeAll()
                    for i in 0..<shapeDataArr.count {
                        let idxPath = IndexPath(row: i, section: 0)
                        if let cell = collectionShap.cellForItem(at: idxPath) as? SearchDiamondCVC {
                            cell.isShadowApplied = false
                        }
                    }
                } else {
                    // Select all
                    for i in 0..<shapeDataArr.count {
                        let idxPath = IndexPath(row: i, section: 0)
                        selectedIndicesShaps.insert(idxPath)
                        shapeArr.append(shapeDataArr[i])
                        if let cell = collectionShap.cellForItem(at: idxPath) as? SearchDiamondCVC {
                            cell.isShadowApplied = true
                        }
                    }
                }
            } else {
                if selectedIndicesShaps.contains(indexPath) {
                    // Deselect the specific item
                    selectedIndicesShaps.remove(indexPath)
                    if let index = shapeArr.firstIndex(of: selectedItem) {
                        shapeArr.remove(at: index)
                    }
                    cell.isShadowApplied = false
                } else {
                    // Select the specific item
                    selectedIndicesShaps.insert(indexPath)
                    shapeArr.append(selectedItem)
                    cell.isShadowApplied = true
                }
                
                // Handle the case where individual items are selected/deselected and "All" should be updated
                if selectedIndicesShaps.count == shapeDataArr.count - 1, let allIndex = shapeDataArr.firstIndex(of: "All") {
                    let allIndexPath = IndexPath(row: allIndex, section: 0)
                    selectedIndicesShaps.insert(allIndexPath)
                    shapeArr.append("All")
                    if let allCell = collectionShap.cellForItem(at: allIndexPath) as? SearchDiamondCVC {
                        allCell.isShadowApplied = true
                    }
                } else if let allIndex = shapeDataArr.firstIndex(of: "All") {
                    let allIndexPath = IndexPath(row: allIndex, section: 0)
                    selectedIndicesShaps.remove(allIndexPath)
                    if let index = shapeArr.firstIndex(of: "All") {
                        shapeArr.remove(at: index)
                    }
                    if let allCell = collectionShap.cellForItem(at: allIndexPath) as? SearchDiamondCVC {
                        allCell.isShadowApplied = false
                    }
                }
            }
            
            if shapeArr.count > 0 {
                self.delegate?.didselectOption(searchTitle: "Shape", details: [], shapeArr: shapeArr)
            }
        }
    }
}