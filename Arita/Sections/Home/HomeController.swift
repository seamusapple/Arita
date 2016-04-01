//
//  HomeController.swift
//  Arita
//
//  Created by DcBunny on 16/3/29.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    // 顶部状态栏
    let titleView = UIView()
    let titleViewBg = UIImageView()
    let titleLabel = UILabel()
    let menuBtn = UIButton()
    let loginBtn = UIButton()
    
    // 首页列表内容
    let homeTable = UITableView()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initComponents()
        addPageSubviews()
        layoutPageSubviews()
        setPageSubviews()
        setPageEvents()
        setDataSourceAndDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("Home Controller memory warning.")
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - init methods
    func initComponents() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.hideLoginBtn), name: "UserLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.showLoginBtn), name: "UserLogout", object: nil)
    }
    
    func addPageSubviews() {
        // 添加顶部状态栏
        view.addSubview(titleView)
        titleView.addSubview(titleViewBg)
        titleView.addSubview(titleLabel)
        titleView.addSubview(menuBtn)
        titleView.addSubview(loginBtn)
        
        // 添加首页列表内容
        view.addSubview(homeTable)
    }
    
    // MARK: - layout and set page subviews
    func layoutPageSubviews() {
        // 顶部状态栏布局
        titleView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(view)
            make.height.equalTo(35)
        }
        
        titleViewBg.snp_makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(titleView)
        }
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(titleView)
            make.size.equalTo(CGSizeMake(50, 20))
        }
        
        menuBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleView).offset(10)
            make.centerY.equalTo(titleView.snp_centerY)
            make.size.equalTo(CGSizeMake(20, 20))
        }
        
        loginBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(titleView).offset(-10)
            make.centerY.equalTo(titleView.snp_centerY)
            make.size.equalTo(CGSizeMake(20, 20))
        }
        
        // 首页列表内容布局
        homeTable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleView.snp_bottom)
            make.left.bottom.right.equalTo(view)
        }
    }
    
    func setPageSubviews() {
        view.backgroundColor = UIColor.whiteColor()
        
        titleViewBg.image = UIImage(named: "homeTitle")
        titleLabel.text = "阿里塔"
        titleLabel.font = FONT_TITLE
        titleLabel.textColor = COLOR_TATA
        titleLabel.textAlignment = NSTextAlignment.Center
        menuBtn.setBackgroundImage(UIImage(named: "menuBtn"), forState: UIControlState.Normal)
        loginBtn.setBackgroundImage(UIImage(named: "userBtn"), forState: UIControlState.Normal)
        if isUserLogin() {
            loginBtn.hidden = true
        }
        
        homeTable.separatorStyle = UITableViewCellSeparatorStyle.None
        homeTable.showsVerticalScrollIndicator = false
        homeTable.allowsSelection = false
        homeTable.registerClass(HomeTataCell.self, forCellReuseIdentifier: "TataCell")
        homeTable.registerClass(HomeCyCell.self, forCellReuseIdentifier: "CyCell")
        homeTable.registerClass(HomeSjCell.self, forCellReuseIdentifier: "SjCell")
        homeTable.registerClass(HomeShCell.self, forCellReuseIdentifier: "ShCell")
        homeTable.registerClass(HomeLpCell.self, forCellReuseIdentifier: "LpCell")
    }
    
    // MARK: - set events, datasource and delegate
    func setPageEvents() {
        loginBtn.addTarget(self, action: #selector(HomeViewController.userLogin), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setDataSourceAndDelegate() {
        homeTable.dataSource = self
        homeTable.delegate = self
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cellId = "TataCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! HomeTataCell
            
            cell.tataTitle.text = "测试测试"
            cell.tataBtn.addTarget(self, action: #selector(HomeController.goTata), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
            
        case 1:
            let cellId = "CyCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! HomeCyCell
            
            let cyImage1 = UIImageView()
            cyImage1.contentMode = UIViewContentMode.ScaleAspectFill
            cyImage1.clipsToBounds = true
            cell.cyCMSView1.primaryView = cyImage1
            let cyTitle1 = UILabel()
            cyTitle1.textAlignment = NSTextAlignment.Center
            cyTitle1.numberOfLines = 3
            cyTitle1.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            cyTitle1.textColor = UIColor.whiteColor()
            cyTitle1.backgroundColor = COLOR_TATA
            cell.cyCMSView1.secondaryView = cyTitle1
            
            let cyImage2 = UIImageView()
            cyImage2.contentMode = UIViewContentMode.ScaleAspectFill
            cyImage2.clipsToBounds = true
            cell.cyCMSView2.primaryView = cyImage2
            let cyTitle2 = UILabel()
            cyTitle2.textAlignment = NSTextAlignment.Center
            cyTitle2.numberOfLines = 3
            cyTitle2.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            cyTitle2.textColor = UIColor.whiteColor()
            cyTitle2.backgroundColor = COLOR_TATA
            cell.cyCMSView2.secondaryView = cyTitle2
            
            let cyImage3 = UIImageView()
            cyImage3.contentMode = UIViewContentMode.ScaleAspectFill
            cyImage3.clipsToBounds = true
            cell.cyCMSView3.primaryView = cyImage3
            let cyTitle3 = UILabel()
            cyTitle3.textAlignment = NSTextAlignment.Center
            cyTitle3.numberOfLines = 3
            cyTitle3.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            cyTitle3.textColor = UIColor.whiteColor()
            cyTitle3.backgroundColor = COLOR_TATA
            cell.cyCMSView3.secondaryView = cyTitle3
            
            cell.cyBtn1.tag = 1
            cell.cyBtn1.addTarget(self, action: #selector(self.goCy(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.cyBtn2.tag = 2
            cell.cyBtn2.addTarget(self, action: #selector(self.goCy(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.cyBtn3.tag = 5
            cell.cyBtn3.addTarget(self, action: #selector(self.goCy(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
            
        case 2:
            let cellId = "SjCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! HomeSjCell
            
            let sjImage1 = UIImageView()
            sjImage1.contentMode = UIViewContentMode.ScaleAspectFill
            sjImage1.clipsToBounds = true
            cell.sjCMSView1.primaryView = sjImage1
            let sjTitle1 = UILabel()
            sjTitle1.textAlignment = NSTextAlignment.Center
            sjTitle1.numberOfLines = 3
            sjTitle1.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            sjTitle1.textColor = UIColor.whiteColor()
            sjTitle1.backgroundColor = COLOR_TATA
            cell.sjCMSView1.secondaryView = sjTitle1
            
            let sjImage2 = UIImageView()
            sjImage2.contentMode = UIViewContentMode.ScaleAspectFill
            sjImage2.clipsToBounds = true
            cell.sjCMSView2.primaryView = sjImage2
            let sjTitle2 = UILabel()
            sjTitle2.textAlignment = NSTextAlignment.Center
            sjTitle2.numberOfLines = 3
            sjTitle2.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            sjTitle2.textColor = UIColor.whiteColor()
            sjTitle2.backgroundColor = COLOR_TATA
            cell.sjCMSView2.secondaryView = sjTitle2
            
            let sjImage3 = UIImageView()
            sjImage3.contentMode = UIViewContentMode.ScaleAspectFill
            sjImage3.clipsToBounds = true
            cell.sjCMSView3.primaryView = sjImage3
            let sjTitle3 = UILabel()
            sjTitle3.textAlignment = NSTextAlignment.Center
            sjTitle3.numberOfLines = 3
            sjTitle3.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            sjTitle3.textColor = UIColor.whiteColor()
            sjTitle3.backgroundColor = COLOR_TATA
            cell.sjCMSView3.secondaryView = sjTitle3
            
            cell.sjBtn1.tag = 1
            cell.sjBtn1.addTarget(self, action: #selector(self.goSj(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.sjBtn2.tag = 2
            cell.sjBtn2.addTarget(self, action: #selector(self.goSj(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.sjBtn3.tag = 5
            cell.sjBtn3.addTarget(self, action: #selector(self.goSj(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
            
        case 3:
            let cellId = "ShCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! HomeShCell
            
            let shImage1 = UIImageView()
            shImage1.contentMode = UIViewContentMode.ScaleAspectFill
            shImage1.clipsToBounds = true
            cell.shCMSView1.primaryView = shImage1
            let shTitle1 = UILabel()
            shTitle1.textAlignment = NSTextAlignment.Center
            shTitle1.numberOfLines = 3
            shTitle1.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            shTitle1.textColor = UIColor.whiteColor()
            shTitle1.backgroundColor = COLOR_TATA
            cell.shCMSView1.secondaryView = shTitle1
            
            let shImage2 = UIImageView()
            shImage2.contentMode = UIViewContentMode.ScaleAspectFill
            shImage2.clipsToBounds = true
            cell.shCMSView2.primaryView = shImage2
            let shTitle2 = UILabel()
            shTitle2.textAlignment = NSTextAlignment.Center
            shTitle2.numberOfLines = 3
            shTitle2.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            shTitle2.textColor = UIColor.whiteColor()
            shTitle2.backgroundColor = COLOR_TATA
            cell.shCMSView2.secondaryView = shTitle2
            
            let shImage3 = UIImageView()
            shImage3.contentMode = UIViewContentMode.ScaleAspectFill
            shImage3.clipsToBounds = true
            cell.shCMSView3.primaryView = shImage3
            let shTitle3 = UILabel()
            shTitle3.textAlignment = NSTextAlignment.Center
            shTitle3.numberOfLines = 3
            shTitle3.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            shTitle3.textColor = UIColor.whiteColor()
            shTitle3.backgroundColor = COLOR_TATA
            cell.shCMSView3.secondaryView = shTitle3
            
            cell.shBtn1.tag = 1
            cell.shBtn1.addTarget(self, action: #selector(self.goSh(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.shBtn2.tag = 2
            cell.shBtn2.addTarget(self, action: #selector(self.goSh(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.shBtn3.tag = 5
            cell.shBtn3.addTarget(self, action: #selector(self.goSh(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
            
        default:
            let cellId = "LpCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! HomeLpCell
            
            let lpImage1 = UIImageView()
            lpImage1.contentMode = UIViewContentMode.ScaleAspectFill
            lpImage1.clipsToBounds = true
            cell.lpCMSView1.primaryView = lpImage1
            let lpTitle1 = UILabel()
            lpTitle1.textAlignment = NSTextAlignment.Center
            lpTitle1.numberOfLines = 3
            lpTitle1.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            lpTitle1.textColor = UIColor.whiteColor()
            lpTitle1.backgroundColor = COLOR_TATA
            cell.lpCMSView1.secondaryView = lpTitle1
            
            let lpImage2 = UIImageView()
            lpImage2.contentMode = UIViewContentMode.ScaleAspectFill
            lpImage2.clipsToBounds = true
            cell.lpCMSView2.primaryView = lpImage2
            let lpTitle2 = UILabel()
            lpTitle2.textAlignment = NSTextAlignment.Center
            lpTitle2.numberOfLines = 3
            lpTitle2.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            lpTitle2.textColor = UIColor.whiteColor()
            lpTitle2.backgroundColor = COLOR_TATA
            cell.lpCMSView2.secondaryView = lpTitle2
            
            let lpImage3 = UIImageView()
            lpImage3.contentMode = UIViewContentMode.ScaleAspectFill
            lpImage3.clipsToBounds = true
            cell.lpCMSView3.primaryView = lpImage3
            let lpTitle3 = UILabel()
            lpTitle3.textAlignment = NSTextAlignment.Center
            lpTitle3.numberOfLines = 3
            lpTitle3.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            lpTitle3.textColor = UIColor.whiteColor()
            lpTitle3.backgroundColor = COLOR_TATA
            cell.lpCMSView3.secondaryView = lpTitle3
            
            let lpImage4 = UIImageView()
            lpImage4.contentMode = UIViewContentMode.ScaleAspectFill
            lpImage4.clipsToBounds = true
            cell.lpCMSView4.primaryView = lpImage4
            let lpTitle4 = UILabel()
            lpTitle4.textAlignment = NSTextAlignment.Center
            lpTitle4.numberOfLines = 3
            lpTitle4.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            lpTitle4.textColor = UIColor.whiteColor()
            lpTitle4.backgroundColor = COLOR_TATA
            cell.lpCMSView4.secondaryView = lpTitle4
            
            let lpImage5 = UIImageView()
            lpImage5.contentMode = UIViewContentMode.ScaleAspectFill
            lpImage5.clipsToBounds = true
            cell.lpCMSView5.primaryView = lpImage5
            let lpTitle5 = UILabel()
            lpTitle5.textAlignment = NSTextAlignment.Center
            lpTitle5.numberOfLines = 3
            lpTitle5.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            lpTitle5.textColor = UIColor.whiteColor()
            lpTitle5.backgroundColor = COLOR_TATA
            cell.lpCMSView5.secondaryView = lpTitle5
            
            let lpImage6 = UIImageView()
            lpImage6.contentMode = UIViewContentMode.ScaleAspectFill
            lpImage6.clipsToBounds = true
            cell.lpCMSView6.primaryView = lpImage6
            let lpTitle6 = UILabel()
            lpTitle6.textAlignment = NSTextAlignment.Center
            lpTitle6.numberOfLines = 3
            lpTitle6.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
            lpTitle6.textColor = UIColor.whiteColor()
            lpTitle6.backgroundColor = COLOR_TATA
            cell.lpCMSView6.secondaryView = lpTitle6
            
            cell.lpBtn1.tag = 0
            cell.lpBtn1.addTarget(self, action: #selector(self.goLp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.lpBtn2.tag = 1
            cell.lpBtn2.addTarget(self, action: #selector(self.goLp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.lpBtn3.tag = 1
            cell.lpBtn3.addTarget(self, action: #selector(self.goLp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.lpBtn4.tag = 1
            cell.lpBtn4.addTarget(self, action: #selector(self.goLp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.lpBtn5.tag = 1
            cell.lpBtn5.addTarget(self, action: #selector(self.goLp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.lpBtn6.tag = 2
            cell.lpBtn6.addTarget(self, action: #selector(self.goLp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row != 4 {
            return (SCREEN_WIDTH - 20) / 3 * 2 + 8
        } else {
            return (SCREEN_WIDTH - 20) / 3 * 2 + 44
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 1:
            let cyCell = cell as! HomeCyCell
            cyCell.startFlip()
            
        case 2:
            let sjCell = cell as! HomeSjCell
            sjCell.startFlip()
            
        case 3:
            let shCell = cell as! HomeShCell
            shCell.startFlip()
            
        case 4:
            let lpCell = cell as! HomeLpCell
            lpCell.startFlip()
            
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 1:
            let cyCell = cell as! HomeCyCell
            cyCell.stopFlip()
            
        case 2:
            let sjCell = cell as! HomeSjCell
            sjCell.stopFlip()
            
        case 3:
            let shCell = cell as! HomeShCell
            shCell.stopFlip()
            
        case 4:
            let lpCell = cell as! HomeLpCell
            lpCell.stopFlip()
            
        default:
            break
        }
    }
    
    // MARK: - event response
    func goTata() {
        let tata = TataViewController()
        self.view.window!.rootViewController!.presentViewController(tata, animated: true, completion: nil)
    }
    
    func goCy(sender: UIButton) {
        let cy = ArticleViewController(segueId: "cySegue", segmentId: (sender.tag - 1) % 6)
        self.view.window!.rootViewController!.presentViewController(cy, animated: true, completion: nil)
    }
    
    func goSj(sender: UIButton) {
        let sj = ArticleViewController(segueId: "sjSegue", segmentId: (sender.tag - 1) % 6)
        self.view.window!.rootViewController!.presentViewController(sj, animated: true, completion: nil)
    }
    
    func goSh(sender: UIButton) {
        let sh = ArticleViewController(segueId: "shSegue", segmentId: (sender.tag - 1) % 6)
        self.view.window!.rootViewController!.presentViewController(sh, animated: true, completion: nil)
    }
    
    func goLp(sender: UIButton) {
        let goods = GoodsHomeController(segmentId: sender.tag)
        self.view.window!.rootViewController!.presentViewController(goods, animated: true, completion: nil)
    }
    
    func userLogin() {
        dispatch_async(dispatch_get_main_queue(), { [unowned self] in
            let thirdPartLoginController = ThirdPartLoginController()
            
            thirdPartLoginController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            thirdPartLoginController.providesPresentationContextTransitionStyle = true
            thirdPartLoginController.definesPresentationContext = true
            thirdPartLoginController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            
            self.view.window!.rootViewController!.presentViewController(thirdPartLoginController , animated:true, completion: nil)
        })
    }
    
    func hideLoginBtn() {
        loginBtn.hidden = true
    }
    
    func showLoginBtn() {
        loginBtn.hidden = false
    }
    
    //MARK: - private methods
    func isUserLogin() -> Bool {
        let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
        if userId != nil {
            return true
        } else {
            return false
        }
    }
}
