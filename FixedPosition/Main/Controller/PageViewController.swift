//
//  PageViewController.swift
//  FixedPosition
//
//  Created by 飞翔 on 2020/6/4.
//  Copyright © 2020 飞翔. All rights reserved.
//

import UIKit

let cellID = "cellID"

class PageViewController: UIViewController {
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DataCell.self, forCellReuseIdentifier: cellID)
        return tableView
    }()
    
    var dataSource:[DataObj]?
    
    ///控制视图能否滚动
    var canScroll:Bool = false{
        didSet{
            self.tableView.isScrollEnabled = oldValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        view.addSubview(tableView)
        self.canScroll = false
        self.dataSource = DataObj.loadData()
    }
}

extension  PageViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DataCell
        
        let dataObj = self.dataSource![indexPath.row]
        cell.update(name: dataObj.name!, age: dataObj.age!, sex: dataObj.sex!)
        
        return cell
    }
}

extension PageViewController:UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension PageViewController:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (!self.canScroll) {
            scrollView.contentOffset = CGPoint.zero;
        }
        
        let offsetY = scrollView.contentOffset.y
        if offsetY<=0 {
            //代表下拉 告诉主视图可以滚动 子视图不能滚动
            self.canScroll = false
            scrollView.contentOffset = CGPoint.zero
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: CALLBACKNOTIFICATION), object: nil, userInfo: ["canScroll":true])
        }
        
        self.tableView.showsVerticalScrollIndicator =  false
    }
}
