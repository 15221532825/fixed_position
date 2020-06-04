//
//  ContentView.swift
//  FixedPosition
//
//  Created by 飞翔 on 2020/6/4.
//  Copyright © 2020 飞翔. All rights reserved.
//

import UIKit

protocol ContentViewDelegate{
    
    func scrollViewDidEndTag(tag:Int)
}

class ContentView: UIView {

    var buttonsAry = [String]();
    var controller = UIViewController()
    
    var controllerAry = [PageViewController]()
    var contentViewDelegate:ContentViewDelegate?
    
    lazy var contentScrollView:UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.zero)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    init(frame: CGRect,buttonsAry:[String],childVC:UIViewController) {
        
        super.init(frame: frame)
        self.buttonsAry = buttonsAry
        self.controller = childVC
        self.contentScrollView.frame = self.bounds
        self.backgroundColor = .red
        prepare()
    }
    
    func prepare() {
        
        contentScrollView.contentSize = CGSize.init(width: buttonsAry.count * Int(SCREEN_WIDTH), height: 0)
        contentScrollView.backgroundColor = .green
        self.addSubview(contentScrollView)
        contentScrollView.delegate = self
        
        for index in 0..<buttonsAry.count {
            let pageController = PageViewController()
            controller.addChild(pageController)
            pageController.view.backgroundColor = UIColor.init(red: (CGFloat(arc4random()%255))/255.0, green:(CGFloat(arc4random()%255))/255.0 , blue: (CGFloat(arc4random()%255))/255.0, alpha: 1)
            pageController.view.frame = CGRect.init(x:CGFloat(index) * SCREEN_WIDTH  , y: 0, width: SCREEN_WIDTH, height: self.frame.size.height)
            contentScrollView.addSubview(pageController.view)
            controllerAry.append(pageController)
        }
    }
    
    
    func updateScroll( canScroll:Bool){
       
   
        for controller in self.controllerAry {
            controller.canScroll = canScroll
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ContentView:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let tag  = scrollView.contentOffset.x / self.frame.size.width
        if let delegate = self.contentViewDelegate{
            
            delegate.scrollViewDidEndTag(tag: Int(tag))
        }
        
    }
}
