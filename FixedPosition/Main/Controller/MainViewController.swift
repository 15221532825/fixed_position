//
//  MainViewController.swift
//  FixedPosition
//
//  Created by 飞翔 on 2020/6/4.
//  Copyright © 2020 飞翔. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    let dataAry = ["测试1","测试2","测试3","测试4","测试5","测试6","测试7"];
    
    lazy var bgScrollView:UIScrollView = {
        let bgScrollView  = UIScrollView.init(frame: self.view.bounds)
        bgScrollView.showsVerticalScrollIndicator = true
        bgScrollView.contentSize = CGSize.init(width: 0, height: Int(SCREEN_HEIGHT) + FixedHeight)
        bgScrollView.delegate = self
        return bgScrollView
    }()
    
    lazy var titleHeadView:TitleHeadView = {
        let headView = TitleHeadView.init(frame: CGRect.init(x: 0, y: FixedHeight, width: Int(SCREEN_WIDTH), height: titleHeight), buttons: self.dataAry)
        headView.titleCiickDelegate  = self
        return headView
    }()
    
    
    lazy var contentView:ContentView = {
        let contentView = ContentView.init(frame: CGRect.init(x: 0, y:self.titleHeadView.frame.origin.y+CGFloat(titleHeight), width: SCREEN_WIDTH, height: SCREEN_HEIGHT-CGFloat(titleHeight)), buttonsAry: self.dataAry, childVC: self)
        contentView.contentViewDelegate = self
        return contentView
    }()
    
    ///标记主视图是否可以滚动
    var canScroll = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout =  []
        
        prepare()
        
        addNotification()
    }
    
    func prepare() {
        view.addSubview(bgScrollView)
        bgScrollView.addSubview(titleHeadView)
        bgScrollView.addSubview(contentView)
    }
    
    ///添加通知
    func addNotification()  {
        NotificationCenter.default.addObserver(self, selector: #selector(changeStatus), name:NSNotification.Name(rawValue:CALLBACKNOTIFICATION) , object: nil)
        
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(CALLBACKNOTIFICATION), object: nil)
    }
}

extension MainViewController:TitleHeadViewDelegate,ContentViewDelegate{
    
    func buttonClick(_ sender: UIButton) {
        self.contentView.contentScrollView.setContentOffset(CGPoint.init(x: sender.tag * Int(SCREEN_WIDTH), y: 0), animated: true)
    }
    
    func scrollViewDidEndTag(tag: Int) {
        
        self.titleHeadView.click(sender: self.titleHeadView.buttonsAry[tag] as! UIButton)
    }
}

extension MainViewController:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y;
        let isScrollToTop = offsetY >= CGFloat(FixedHeight)
        if isScrollToTop{
            scrollView.contentOffset = CGPoint.init(x: 0, y: FixedHeight)
            ///禁止主视图滚动  允许子视图滚动
            if self.canScroll{
                self.canScroll = false
            }
            contentView.updateScroll(canScroll: true)
            
        }else{
            
            if !self.canScroll {
               scrollView.contentOffset = CGPoint.init(x: 0, y: FixedHeight)
            }
        }
    }
}

extension MainViewController:UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension MainViewController{
    
    @objc func changeStatus(note:Notification)  {
        
        self.canScroll = true
        contentView.updateScroll(canScroll: false)
    }
}
