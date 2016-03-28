//
//  UserInfoController.swift
//  Arita
//
//  Created by DcBunny on 15/9/8.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class UserInfoController: UIViewController, UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var userLogo: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var genderM: UIButton!
    @IBOutlet weak var genderF: UIButton!
    @IBOutlet weak var userXz: UILabel!
    @IBOutlet weak var userAddr: UILabel!
    
    @IBOutlet weak var backGroundView: UIView!
    var alphaView = UIView()
    var baseView = UIView()
    let tapGesture = UITapGestureRecognizer()
    
    var showBtn = UIButton()
    
    var pickArea = UIView()
    var optionView = UIView()
    var cancelBtn = UIButton()
    var finishBtn = UIButton()
    var birthdayPicker = UIDatePicker()
    var addrPicker = UIPickerView()
    
    var pickerData : NSDictionary!
    var pickerProvincesData : NSArray!
    var tmpCitiesData : NSDictionary!
    var pickerCitiesData : NSArray!
    var pickerAreaData : NSArray!
    
    var province = ""
    var city = ""
    var area = ""
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userLogo.layer.masksToBounds = true
        self.userLogo.layer.cornerRadius = 39
        
        let userName = NSUserDefaults.standardUserDefaults().stringForKey("nickname")
        if userName != nil {
            self.nickName.text = userName
            
            let imageUrl = NSUserDefaults.standardUserDefaults().stringForKey("usericon")
            self.userLogo.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: UIImage(named: "portrait"))
            
            switch NSUserDefaults.standardUserDefaults().valueForKey("gender") as! Int {
            case 0:
                self.genderM.setImage(UIImage(named: "sex_boyCurrent"), forState: UIControlState.Normal)
                self.genderF.setImage(UIImage(named: "sex_girl"), forState: UIControlState.Normal)
            case 1:
                self.genderF.setImage(UIImage(named: "sex_girlCurrent"), forState: UIControlState.Normal)
                self.genderM.setImage(UIImage(named: "sex_boy"), forState: UIControlState.Normal)
            default:
                break
            }
        }
        
        self.view.addSubview(self.backGroundView)
        self.backGroundView.addSubview(self.alphaView)
        self.backGroundView.addSubview(self.baseView)
        self.baseView.addGestureRecognizer(tapGesture)
        
        self.backGroundView.addSubview(self.pickArea)
        self.pickArea.addSubview(self.optionView)
        self.optionView.addSubview(self.cancelBtn)
        self.optionView.addSubview(self.finishBtn)
        self.pickArea.addSubview(self.birthdayPicker)
        
        self.pickArea.addSubview(self.addrPicker)
        
        self.layoutPageSubviews()
        self.setPageSubviews()
        self.setSubviewEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func layoutPageSubviews() {
        self.alphaView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.backGroundView).inset(0)
        }
        
        self.baseView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.backGroundView).inset(0)
        }
        
        self.pickArea.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.optionView.snp_top)
            make.left.right.bottom.equalTo(self.backGroundView)
        }
        
        self.optionView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.pickArea)
            make.bottom.equalTo(self.birthdayPicker.snp_top)
            make.height.equalTo(44)
        }
        
        self.cancelBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.optionView).offset(15)
            make.top.bottom.equalTo(self.optionView)
            make.width.equalTo(44)
        }
        
        self.finishBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.optionView).offset(-15)
            make.top.bottom.equalTo(self.optionView)
            make.width.equalTo(44)
        }
        
        self.birthdayPicker.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.pickArea)
        }
        
        self.addrPicker.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.pickArea)
        }
    }
    
    func setPageSubviews() {
        self.backGroundView.backgroundColor = UIColor.clearColor()
        self.alphaView.backgroundColor = UIColor.clearColor()
        self.baseView.backgroundColor = UIColor.blackColor()
        self.baseView.alpha = 0.4
        self.backGroundView.hidden = true
        
        self.pickArea.backgroundColor = UIColor.whiteColor()
        self.optionView.backgroundColor = UIColor(red: 215 / 255.0, green: 215 / 255.0, blue: 215 / 255.0, alpha: 1.0)
        self.cancelBtn.setTitle("取消", forState: UIControlState.Normal)
        self.cancelBtn.setTitleColor(UIColor(red: 32 / 255, green: 177 / 255, blue: 232 / 255, alpha: 1.0), forState: UIControlState.Normal)
        self.cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.finishBtn.setTitle("确定", forState: UIControlState.Normal)
        self.finishBtn.setTitleColor(UIColor(red: 32 / 255, green: 177 / 255, blue: 232 / 255, alpha: 1.0), forState: UIControlState.Normal)
        self.finishBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        
        let ageString = NSUserDefaults.standardUserDefaults().stringForKey("userage")
        if (ageString != nil) {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            self.birthdayPicker.date = dateFormatter.dateFromString(ageString!)!
            
            dateFormatter.dateFormat = "yyyy"
            let userAgeString = dateFormatter.stringFromDate(self.birthdayPicker.date)
            let userAge = dateFormatter.dateFromString(userAgeString)
            let tmpNow = NSDate()
            let nowString = dateFormatter.stringFromDate(tmpNow)
            let now = dateFormatter.dateFromString(nowString)
            let ageTime = now!.timeIntervalSinceDate(userAge!)
            let years = ageTime / 3600 / 24 / 365
            self.userAge.text = String(Int(years))
            
            dateFormatter.dateFormat = "MMdd"
            let xz = dateFormatter.stringFromDate(self.birthdayPicker.date)
            if (xz >= "0321" && xz <= "0419") {
                self.userXz.text = "白羊"
            } else if (xz >= "0420" && xz <= "0520") {
                self.userXz.text = "金牛"
            } else if (xz >= "0521" && xz <= "0621") {
                self.userXz.text = "双子"
            } else if (xz >= "0622" && xz <= "0722") {
                self.userXz.text = "巨蟹"
            } else if (xz >= "0723" && xz <= "0822") {
                self.userXz.text = "狮子"
            } else if (xz >= "0823" && xz <= "0922") {
                self.userXz.text = "处女"
            } else if (xz >= "0923" && xz <= "1023") {
                self.userXz.text = "天秤"
            } else if (xz >= "1024" && xz <= "1122") {
                self.userXz.text = "天蝎"
            } else if (xz >= "1123" && xz <= "1221") {
                self.userXz.text = "射手"
            } else if (xz >= "1122" && xz <= "0119") {
                self.userXz.text = "摩羯"
            } else if (xz >= "0120" && xz <= "0218") {
                self.userXz.text = "水瓶"
            } else {
                self.userXz.text = "双鱼"
            }
            
            self.userAddr.text = NSUserDefaults.standardUserDefaults().stringForKey("useraddr")
        }
        self.birthdayPicker.datePickerMode = UIDatePickerMode.Date
        self.birthdayPicker.locale = NSLocale(localeIdentifier: "zh_CN")
        
        let plistPath = NSBundle.mainBundle().pathForResource("area", ofType: "plist")
        self.pickerData = NSDictionary(contentsOfFile: plistPath!)
        self.pickerProvincesData = self.pickerData.allKeys
        let seletedProvince = self.pickerProvincesData[0] as! NSString
        self.tmpCitiesData = self.pickerData[seletedProvince] as! NSDictionary
        self.pickerCitiesData = self.tmpCitiesData.allKeys
        let seletedCity = self.pickerCitiesData[0] as! NSString
        self.pickerAreaData = self.tmpCitiesData[seletedCity] as! NSArray
    }
    
    func setSubviewEvents() {
        self.addrPicker.delegate = self
        self.addrPicker.dataSource = self
        
        self.tapGesture.addTarget(self, action: #selector(UserInfoController.cancel))
        
        self.cancelBtn.addTarget(self, action: #selector(UserInfoController.cancel), forControlEvents: UIControlEvents.TouchUpInside)
        self.finishBtn.addTarget(self, action: #selector(UserInfoController.finish), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return self.pickerProvincesData.count
        } else if (component == 1) {
            return self.pickerCitiesData.count
        } else {
            return self.pickerAreaData.count
        }
    }
    
    //MARK: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return self.pickerProvincesData[row] as? String
        } else if (component == 1) {
            return self.pickerCitiesData[row] as? String
        } else {
            return self.pickerAreaData[row] as? String
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            let seletedProvince = self.pickerProvincesData[row] as! NSString
            self.tmpCitiesData = self.pickerData[seletedProvince] as! NSDictionary
            self.pickerCitiesData = self.tmpCitiesData.allKeys
            self.addrPicker.reloadComponent(1)
            self.province = seletedProvince as String
            let seletedCity = self.pickerCitiesData[0] as! NSString
            self.pickerAreaData = self.tmpCitiesData[seletedCity] as! NSArray
            self.addrPicker.reloadComponent(2)
            self.city = seletedCity as String
        } else if (component == 1) {
            let seletedCity = self.pickerCitiesData[row] as! NSString
            self.pickerAreaData = self.tmpCitiesData[seletedCity] as! NSArray
            self.addrPicker.reloadComponent(2)
        } else {
            self.area = self.pickerAreaData[row] as! String
        }
    }
    
    //MARK: - UIAlertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            print("取消")
        case 1:
            self.nickName.text = alertView.textFieldAtIndex(0)?.text
            NSUserDefaults.standardUserDefaults().setValue(self.nickName.text, forKey: "nickname")
            NSUserDefaults.standardUserDefaults().synchronize()
            NSNotificationCenter.defaultCenter().postNotificationName("ReloadNickName", object: nil)
        default:
            break
        }
    }
    
    //MARK: - event response
    func cancel() {
        self.backGroundView.hidden = true
    }
    
    func finish() {
        self.backGroundView.hidden = true
        if (!self.birthdayPicker.hidden) {
            let birthday = self.birthdayPicker.date
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let ageString = dateFormatter.stringFromDate(birthday)
            NSUserDefaults.standardUserDefaults().setValue(ageString, forKey: "userage")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            dateFormatter.dateFormat = "yyyy"
            let userAgeString = dateFormatter.stringFromDate(self.birthdayPicker.date)
            let userAge = dateFormatter.dateFromString(userAgeString)
            let tmpNow = NSDate()
            let nowString = dateFormatter.stringFromDate(tmpNow)
            let now = dateFormatter.dateFromString(nowString)
            let ageTime = now!.timeIntervalSinceDate(userAge!)
            let years = ageTime / 3600 / 24 / 365
            self.userAge.text = String(Int(years))
            
            dateFormatter.dateFormat = "MMdd"
            let xz = dateFormatter.stringFromDate(self.birthdayPicker.date)
            if (xz >= "0321" && xz <= "0419") {
                self.userXz.text = "白羊"
            } else if (xz >= "0420" && xz <= "0520") {
                self.userXz.text = "金牛"
            } else if (xz >= "0521" && xz <= "0621") {
                self.userXz.text = "双子"
            } else if (xz >= "0622" && xz <= "0722") {
                self.userXz.text = "巨蟹"
            } else if (xz >= "0723" && xz <= "0822") {
                self.userXz.text = "狮子"
            } else if (xz >= "0823" && xz <= "0922") {
                self.userXz.text = "处女"
            } else if (xz >= "0923" && xz <= "1023") {
                self.userXz.text = "天秤"
            } else if (xz >= "1024" && xz <= "1122") {
                self.userXz.text = "天蝎"
            } else if (xz >= "1123" && xz <= "1221") {
                self.userXz.text = "射手"
            } else if (xz >= "1122" && xz <= "0119") {
                self.userXz.text = "摩羯"
            } else if (xz >= "0120" && xz <= "0218") {
                self.userXz.text = "水瓶"
            } else {
                self.userXz.text = "双鱼"
            }
        } else {
            let addrString = self.city + " " + self.area
            NSUserDefaults.standardUserDefaults().setValue(addrString, forKey: "useraddr")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.userAddr.text = addrString
        }
    }
    
    @IBAction func backToHome() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func changeTx() {
        self.backGroundView.hidden = false
    }
    
    @IBAction func changeName(sender: UIButton) {
        let alertView = UIAlertView()
        alertView.delegate = self
        alertView.message = "请输入您的昵称"
        alertView.addButtonWithTitle("取消")
        alertView.addButtonWithTitle("好的")
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alertView.show()
    }
    
    @IBAction func changeAge(sender: UIButton) {
        self.backGroundView.hidden = false
        self.birthdayPicker.hidden = false
        self.addrPicker.hidden = true
    }
    
    @IBAction func selectMale(sender: UIButton) {
        self.genderM.setImage(UIImage(named: "sex_boyCurrent"), forState: UIControlState.Normal)
        self.genderF.setImage(UIImage(named: "sex_girl"), forState: UIControlState.Normal)
        NSUserDefaults.standardUserDefaults().setValue(0, forKey: "gender")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func selectFemale(sender: UIButton) {
        self.genderM.setImage(UIImage(named: "sex_boy"), forState: UIControlState.Normal)
        self.genderF.setImage(UIImage(named: "sex_girlCurrent"), forState: UIControlState.Normal)
        NSUserDefaults.standardUserDefaults().setValue(1, forKey: "gender")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func changeAddr(sender: UIButton) {
        self.backGroundView.hidden = false
        self.birthdayPicker.hidden = true
        self.addrPicker.hidden = false
    }
}
