//
//  DataObj.swift
//  FixedPosition
//
//  Created by 飞翔 on 2020/6/4.
//  Copyright © 2020 飞翔. All rights reserved.
//

import UIKit

class DataObj: NSObject {
    
    var name:String?
    var sex:String?
    var age:String?
    
    static func loadData() -> [DataObj] {
        
        let dataAry = [["name":"Jack","sex":"male","age":"18"],
                       ["name":"Peter","sex":"male","age":"19"],
                       ["name":"Monkey","sex":"male","age":"20"],
                       ["name":"Tom","sex":"male","age":"21"],
                       ["name":"Tom","sex":"male","age":"22"],
                       ["name":"Lisy","sex":"female","age":"23"],
                       ["name":"Rose","sex":"female","age":"24"],
                       ["name":"Jim","sex":"male","age":"25"],
                       ["name":"Lilei","sex":"male","age":"26"],
                       ["name":"WuTao","sex":"male","age":"27"],
                       ["name":"Jack","sex":"male","age":"18"],
                       ["name":"Peter","sex":"male","age":"19"],
                       ["name":"Monkey","sex":"male","age":"20"],
                       ["name":"Tom","sex":"male","age":"21"],
                       ["name":"Tom","sex":"male","age":"22"],
                       ["name":"Lisy","sex":"female","age":"23"],
                       ["name":"Rose","sex":"female","age":"24"],
                       ["name":"Jim","sex":"male","age":"25"],
                       ["name":"Lilei","sex":"male","age":"26"],
                       ["name":"WuTao","sex":"male","age":"27"],
                       ["name":"Jack","sex":"male","age":"18"],
                       ["name":"Peter","sex":"male","age":"19"],
                       ["name":"Monkey","sex":"male","age":"20"],
                       ["name":"Tom","sex":"male","age":"21"],
                       ["name":"Tom","sex":"male","age":"22"],
                       ["name":"Lisy","sex":"female","age":"23"],
                       ["name":"Rose","sex":"female","age":"24"],
                       ["name":"Jim","sex":"male","age":"25"],
                       ["name":"Lilei","sex":"male","age":"26"],
                       ["name":"WuTao","sex":"male","age":"27"]
        ]
        
        var sourceAry = [DataObj]()
        
        for  dict:Dictionary in dataAry {
            
            let model = DataObj()
            model.name = dict["name"]!
            model.age = dict["age"]!
            model.sex = dict["sex"];
            sourceAry.append(model)
        }
        
        return sourceAry
    }
}
