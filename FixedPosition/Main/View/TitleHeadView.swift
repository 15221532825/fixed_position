//
//  TitleHeadView.swift
//  FixedPosition
//
//  Created by 飞翔 on 2020/6/4.
//  Copyright © 2020 飞翔. All rights reserved.
//

import UIKit

protocol TitleHeadViewDelegate {

    ///按钮点击方法
    func buttonClick(_ sender:UIButton);
    
}

let indicatorViewHeight = 2
///标题视图
class TitleHeadView: UIView {
    
    var buttonsTitleAry = [String]()
    var buttonWidth = 80
    
    ///存放按钮数组
    var buttonsAry = [AnyObject]()
    
    var titleCiickDelegate:TitleHeadViewDelegate?
    
    //mark:- lazy
    
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var indicatorView:UIView = {
        
        let indicatorView = UIView.init(frame: CGRect.init(x: 0, y: Int(self.frame.size.height - CGFloat(indicatorViewHeight+1)), width: self.buttonWidth, height: indicatorViewHeight))
        indicatorView.backgroundColor = .red
        return indicatorView
    }()
    
    init(frame: CGRect,buttons:[String]) {
        
        super.init(frame: frame)
        
        self.buttonsTitleAry = buttons
        
        ///初始化视图
        prepare()
    }
    
    
    func  prepare() {
        
        self.scrollView.frame = self.bounds
        self.scrollView.contentSize = CGSize.init(width:buttonWidth * self.buttonsTitleAry.count , height: 0)
        scrollView.backgroundColor =  UIColor.init(white: 0.6, alpha: 0.4)
        self.scrollView.showsHorizontalScrollIndicator = false
        
        addSubview(scrollView)
        scrollView.addSubview(indicatorView)
        
        for index in 0..<buttonsTitleAry.count {
            let button = UIButton.init(type: .custom)
            button.setTitle(buttonsTitleAry[index], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.red, for: .selected)
            button.addTarget(self, action: #selector(click), for:.touchUpInside )
            button.frame = CGRect.init(x: index * buttonWidth, y: 0, width: buttonWidth, height: Int(self.frame.size.height-4))

            button.tag = index
            buttonsAry.append(button)
            scrollView.addSubview(button)
            if index==0 {
                updateCenter(button: button)
            }
        }
    }
    
    @objc func  click(sender:UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            self.updateCenter(button: sender)
        }
        
        ///计算偏移量
        let  senderX = sender.center.x;
        let  centerX = self.center.x;
        
        let maxaDelta = self.scrollView.contentSize.width - self.frame.size.width;
        var deltaX = (senderX - centerX)
        if deltaX <= 0 {
            deltaX = 0.0
        }
        if deltaX >=  maxaDelta {
            deltaX = maxaDelta;
        }
        scrollView.setContentOffset(CGPoint.init(x: deltaX, y: 0), animated: true)
        if let delegate = titleCiickDelegate{
            
            delegate.buttonClick(sender)
        }
        
    }
    
    ///更新indicatorView的中心点
    func updateCenter(button:UIButton)  {
        
        var center = indicatorView.center
        center.x = button.center.x;
        indicatorView.center = center
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
