//
//  ViewController.swift
//  Swift_JiSuanQi
//
//  Created by zhaotf on 15/6/16.
//  Copyright (c) 2015年 zhaotf. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var numbers:[String] = [String]()
    var numbers2:[String] = [String]()
    
    private let TAG_JIA = "+"
    private let TAG_JIAN = "-"
    private let TAG_CHENG = "×"
    private let TAG_CHU = "÷"
    private let TAG_WU_QIONG_DA = "∞"
    private let TAG_DIAN = "."
    private let TAG_LING = "0"
    
    @IBOutlet weak var num_gongshi: UILabel!
    @IBOutlet weak var num_jieguo: UILabel!
    @IBOutlet weak var num0: UIButton!
    @IBOutlet weak var num1: UIButton!
    @IBOutlet weak var num2: UIButton!
    @IBOutlet weak var num3: UIButton!
    @IBOutlet weak var num4: UIButton!
    @IBOutlet weak var num5: UIButton!
    @IBOutlet weak var num6: UIButton!
    @IBOutlet weak var num7: UIButton!
    @IBOutlet weak var num8: UIButton!
    @IBOutlet weak var num9: UIButton!
    @IBOutlet weak var num_dian: UIButton!
    @IBOutlet weak var num_dengyu: UIButton!
    @IBOutlet weak var num_delete: UIButton!
    @IBOutlet weak var num_jia: UIButton!
    @IBOutlet weak var num_jian: UIButton!
    @IBOutlet weak var num_cheng: UIButton!
    @IBOutlet weak var num_chu: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Main"
        
        //        btnAdd.addTarget(self, action: Selector("btnAction"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //    @IBAction func btnAddAction(sender: UIButton) {
    //    }
    func alert(mTitle: String,mMessage: String) {
        //                UIAlertView(title: mTitle, message: mMessage, delegate: nil, cancelButtonTitle: "返回").show()
    }
    
    
    @IBAction func numAction(sender: UIButton) {
        var tag = sender.tag - 10000
        
        self.view.viewWithTag(10009)
        
        switch sender{
        case num0:
            //            alert("title", mMessage: "0")
            addNumber("0")
            break
        case num1:
            //            alert("title", mMessage: "1")
            addNumber("1")
            break
        case num2:
            //            alert("title", mMessage: "2")
            addNumber("2")
            break
        case num3:
            //            alert("title", mMessage: "3")
            addNumber("3")
            break
        case num4:
            //            alert("title", mMessage: "4")
            addNumber("4")
            break
        case num5:
            //            alert("title", mMessage: "5")
            addNumber("5")
            break
        case num6:
            //            alert("title", mMessage: "6")
            addNumber("6")
            break
        case num7:
            //            alert("title", mMessage: "7")
            addNumber("7")
            break
        case num8:
            //            alert("title", mMessage: "8")
            addNumber("8")
            break
        case num9:
            //            alert("title", mMessage: "9")
            addNumber("9")
            break
        case num_dian:
            //            alert("title", mMessage: ".")
            addNumber(".")
            break
        case num_dengyu:
            jisuan()
            break
        case num_jia:
            addTag(TAG_JIA)
            break
        case num_jian:
            addTag(TAG_JIAN)
            break
        case num_cheng:
            addTag(TAG_CHENG)
            break
        case num_chu:
            addTag(TAG_CHU)
            break
        case num_delete:
            todelete()
            break
            
        default:
            break
        }
        //        if sender == num2 {
        //            print("按了 2")
        //        }
    }
    
    func todelete(){
        if !numbers.isEmpty{
            //如果最后一位是空的
            if numbers[numbers.endIndex-1].isEmpty{
                numbers.removeLast()
                todelete()
                return
            }
                //如果最后一位是运算符
            else if isTag(numbers[numbers.endIndex-1]){
                numbers.removeLast()
            }else{
                //清理最后一个字符
                let aaa = advance(numbers[numbers.endIndex-1].endIndex, -1)
                numbers[numbers.endIndex-1] = numbers[numbers.endIndex-1].substringToIndex(aaa)
                //如果删除后，字符串长度为0
                if numbers[numbers.endIndex-1].isEmpty{
                    numbers.removeLast()
                }
            }
            //界面上清理最后一个字符
            num_gongshi.text! = getAllString(numbers)
            //TODO
            //num_gongshi.text!.substringToIndex(advance(num_gongshi.text!.endIndex,-1))
        }
        jisuan()
    }
    
    func addNumber(num:String){
        if checkAddNumber(num){
            num_gongshi.text! = num_gongshi.text! + num
            
            //保存数组
            if numbers.count == 0{
                numbers.append(num)
            }else if isTag(numbers[numbers.endIndex - 1])  {//如果最后一位是运算符
                numbers.append(num)
            }else{
                numbers[numbers.endIndex - 1] += num
            }
        }
        jisuan()
    }
    func checkAddNumber(addNum:String) -> Bool{
        if numbers.count == 0 {
            return true
        }else{
            //不能有两个小数点
            if addNum == TAG_DIAN && numbers[numbers.endIndex - 1].componentsSeparatedByString(TAG_DIAN).count > 1{
                return false
            }
        }
        return true
        
        //        if("0" == num_gongshi.text && "." != addNum){
        //            num_gongshi.text = ""
        //        }
    }
    func addTag(tag:String){
        if(checkAddTag(tag)){
            num_gongshi.text! = num_gongshi.text! + tag
            numbers.append(tag)
        }
    }
    /**
    点击运算符后，判断
    */
    func checkAddTag(tag:String) -> Bool{
        //        基本类型转换
        //        http://www.ruanman.net/swift/learn/4741.html
        //        NSString(string: numbers.lastObject).doubleValue
        //        numbers.last
        //如果前面没有东西，直接插入运算符
        
        if(numbers.isEmpty || numbers.count == 0){
            if((tag != TAG_JIA && tag != TAG_JIAN)){
                setRes("不可以直接输入X/运算符")
                return false
            }
        }
        
        //判断最后一位是不是运算符
        var lastString = numbers.last!
        //如果最后一个是空数据的话，删除后，重新判断
        if lastString.isEmpty{
            numbers.removeLast()
            return checkAddTag(tag)
        }
        
        if(lastString.isEqual(TAG_JIA) || lastString.isEqual(TAG_JIAN) || lastString.isEqual(TAG_CHENG) || lastString.isEqual(TAG_CHU)){
            return false
        }
        //如果最后两个是“÷”“0”，则提示
        //        if(){
        //
        //        }
        
        return true
    }
    
    func jisuan(){
        
        numbers2 = numbers
        if(!numbers2.isEmpty && numbers2.count != 0 ){
            
            if !allowJiSuan(numbers2){
                setRes("")
                return
            }
            
            //去除第一个是“+”的情况
            if(numbers2.first! == TAG_JIA){
                numbers2.removeAtIndex(0)
            }
            //去除最后一个是运算符的情况
            if(numbers2.last! == TAG_JIA || numbers2.last! == TAG_JIAN || numbers2.last! == TAG_CHENG || numbers2.last! == TAG_CHU){
                numbers2.removeLast()
            }
            
            //先计算乘除
            numbers2 = jisuan_chengchu(numbers2)
            //在计算加减
            numbers2 = jisuan_jiajian(numbers2)
            //处理数据,转成String
            setRes(getAllString(numbers2))
            
        }else{
            setRes("")
        }
    }
    func allowJiSuan(datas:[String]) -> Bool{
        if datas.isEmpty{
            return false
        }else{
            if datas.count <= 2{
                return false
            }else if datas.count == 3{
                //如果是“-1+”的情况，return false
                if isTag(datas[0]) && !isTag(datas[1]) && isTag(datas[2]){
                    return false
                }
            }
        }
        return true
    }
    
    func getAllString(datas:[String]) -> String{
        if datas.isEmpty || datas.count == 0 {
            return ""
        }
        if datas.count == 1{
            return datas[0]
        }
        var allString = ""
        for data in datas{
            allString += data
        }
        return allString
    }
    
    
    /*
    将String转化为数组
    http://www.swiftmi.com/topic/76.html
    */
    func jisuan_jiajian(datas:[String]) -> [String]{
        if datas.isEmpty || datas.count == 0{
            return datas
        }
        
        var aaa = datas
        var num = 0
        for number in datas{
            if num >= 1 && num <= datas.count-2{
                if number == TAG_JIA {
                    
                    aaa.removeAtIndex(num-1)
                    aaa.removeAtIndex(num-1)
                    aaa.removeAtIndex(num-1)
                    aaa.insert(String(stringInterpolationSegment: jia(datas[num-1], number2: datas[num+1])), atIndex: num-1)
                    return jisuan_jiajian(aaa)
                }else if number == TAG_JIAN {
                    aaa.removeAtIndex(num-1)
                    aaa.removeAtIndex(num-1)
                    aaa.removeAtIndex(num-1)
                    aaa.insert(String(stringInterpolationSegment: jian(datas[num-1], number2: datas[num+1])), atIndex: num-1)
                    return jisuan_jiajian(aaa)
                }
            }
            num++
        }
        
        return aaa
    }
    func jisuan_chengchu(datas:[String]) -> [String]{
        
        if datas.isEmpty || datas.count == 0{
            return datas
        }
        
        var aaa = datas
        var num = 0
        for number in datas{
            if num >= 1 && num <= datas.count-2{
                if number == TAG_CHENG {
                    
                    aaa.removeAtIndex(num-1)
                    aaa.removeAtIndex(num-1)
                    aaa.removeAtIndex(num-1)
                    aaa.insert(String(stringInterpolationSegment: cheng(datas[num-1], number2: datas[num+1])), atIndex: num-1)
                    return jisuan_chengchu(aaa)
                }else if number == TAG_CHU {
                    if(aaa[num+1] == TAG_LING){
                        alert("Error", mMessage: " ÷ 0 ???")
                        return ["0"]
                    }
                    aaa.removeAtIndex(num-1)
                    aaa.removeAtIndex(num-1)
                    aaa.removeAtIndex(num-1)
                    aaa.insert(String(stringInterpolationSegment: chu(datas[num-1], number2: datas[num+1])), atIndex: num-1)
                    return jisuan_chengchu(aaa)
                }
            }
            num++
        }
        
        return aaa
    }
    
    func setRes(res:String){
        num_jieguo.text = res
    }
    func jia(number:String,number2:String) -> Double{
        return NSString(string: number).doubleValue + NSString(string: number2).doubleValue
    }
    func jian(number:String,number2:String) -> Double{
        return NSString(string: number).doubleValue - NSString(string: number2).doubleValue
    }
    func cheng(number:String,number2:String) -> Double{
        return NSString(string: number).doubleValue * NSString(string: number2).doubleValue
    }
    func chu(number:String,number2:String) -> Double{
        return NSString(string: number).doubleValue / NSString(string: number2).doubleValue
    }
    func isTag(data:String) -> Bool{
        if data.isEmpty{
            return false
        }
        if data == TAG_JIA || data == TAG_JIAN || data == TAG_CHENG || data == TAG_CHU{
            return true
        }
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

