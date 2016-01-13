//
//  SearchInputController.swift
//  Arita
//
//  Created by DcBunny on 16/1/13.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class SearchInputController: UIViewController, UITextFieldDelegate
{
    let alphaView = UIView()
    let baseView = UIView()
    let tapGesture = UITapGestureRecognizer()
    
    let label1 = UILabel()
    let searchView = UIView()
    let searchInputView = UIView()
    let icon = UIImageView()
    let searchField = UITextField()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.alphaView)
        self.view.addSubview(self.baseView)
        self.view.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(self.label1)
        self.view.addSubview(self.searchView)
        self.searchView.addSubview(self.searchInputView)
        self.searchInputView.addSubview(self.icon)
        self.searchInputView.addSubview(self.searchField)
        
        layoutPageSubviews()
        setupPageSubviews()
        setPageSubviewsEvent()
        setDelegate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: - layout methods
    func layoutPageSubviews() {
        self.alphaView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).inset(0)
        }
        
        self.baseView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).inset(0)
        }
        
        self.label1.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(100)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(20)
        }
        
        self.searchView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.label1.snp_bottom).offset(30)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(60)
        }
        
        self.searchInputView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.searchView).inset(UIEdgeInsetsMake(5, 10, 5, 10))
        }
        
        self.icon.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(18, 18))
            make.left.equalTo(self.searchInputView).offset(15)
            make.centerY.equalTo(self.searchInputView.snp_centerY)
        }
        
        self.searchField.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.icon.snp_right).offset(15)
            make.top.bottom.equalTo(self.searchInputView)
            make.right.equalTo(self.searchInputView).offset(-15)
        }
    }
    
    func setupPageSubviews() {
        self.view.backgroundColor = UIColor.clearColor()
        self.alphaView.backgroundColor = UIColor.clearColor()
        self.baseView.backgroundColor = UIColor.blackColor()
        self.baseView.alpha = 0.85
        
        self.label1.text = "请输入标题内容"
        self.label1.font = UIFont.systemFontOfSize(20)
        self.label1.textColor = UIColor.whiteColor()
        self.label1.textAlignment = NSTextAlignment.Center
        
        self.searchView.backgroundColor = UIColor.whiteColor()
        self.searchView.layer.masksToBounds = true
        self.searchView.layer.cornerRadius = 5
        
        self.searchInputView.backgroundColor = COLOR_BACKGROUND
        self.searchInputView.layer.masksToBounds = true
        self.searchInputView.layer.cornerRadius = 25
        self.searchInputView.layer.borderColor = UIColor(red: 204 / 255.0, green: 204 / 255.0, blue: 204 / 255.0, alpha: 1.0).CGColor
        self.searchInputView.layer.borderWidth = 1
        
        self.icon.image = UIImage(named: "search_icon1")
        
        self.searchField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.searchField.textColor = COLOR_INFO
        self.searchField.font = UIFont.systemFontOfSize(15)
        self.searchField.returnKeyType = UIReturnKeyType.Search
    }
    
    // MARK: - set delegate
    func setDelegate() {
        self.searchField.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let resultController = SearchResultController()
        self.presentViewController(resultController, animated: true, completion: {})
        return true
    }
    
    //MARK: page subviews setting
    func setPageSubviewsEvent() {
        self.tapGesture.addTarget(self, action: Selector("goBackToAlarmList"))
    }
    
    //MARK: - event response
    func goBackToAlarmList() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
}
