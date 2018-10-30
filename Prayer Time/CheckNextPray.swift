//
//  ColoringUI.swift
//  Prayer Time
//
//  Created by Asem Qaffaf on 8/29/18.
//  Copyright © 2018 Asem Qaffaf. All rights reserved.
//

import UIKit


/*
 func colorUI(coloredString: String)-> [NSAttributedString] {
  
    let attStrg1 = [NSAttributedStringKey.foregroundColor : UIColor.yellow]
    let attStrg2 = [NSAttributedStringKey.foregroundColor : UIColor.green]
    let attributeStrin1 = NSAttributedString(string: coloredString, attributes: attStrg1)
    let attributeString2 = NSAttributedString(string: coloredString, attributes: attStrg2)
    
    let arrOfAttribute = [attributeStrin1,attributeString2]
    
    return arrOfAttribute
//    ---------------------- Stack Over Flow Dirve Safe
 
    let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor : UIColor.green]
    
    let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor : UIColor.white]
    
    let attributedString1 = NSMutableAttributedString(string:"Drive", attributes:attrs1)
    
    let attributedString2 = NSMutableAttributedString(string:"safe", attributes:attrs2)
    
    attributedString1.append(attributedString2)
    self.lblText.attributedText = attributedString1
 
}*/

func currentTime() ->String{
    
    let date = Date()
    
    let FormattedTime = DateFormatter()
    FormattedTime.dateFormat = "HH:mm"
    let timeStr = FormattedTime.string(from: date)
    
    
    return timeStr
}



func caculatePrayTime(prayArray: [String.SubSequence]) -> Int{
                                                                                //Fajr Index in prayArray Array is:      1
                                                                                //Sunrise Index in prayArray Array is:   3
                                                                                //Dhuhr Index in prayArray Array is:     5
                                                                                //Asr Index in prayArray Array is:       7
     var arrayOfTime = [String]()                                               //Sunset Index in prayArray Array is:    9
                                                                                //Maghrib Index in prayArray Array is:   11
                                                                                //Isha Index in prayArray Array is:      13
                                                                                //Imsak Index in prayArray Array is:     15
                                                                                //Midnight Index in prayArray Array is:  17
    
    //----------------------------------------------------------------------------------------------------------------//
   
    for i in 0..<prayArray.count{
        if i % 2 == 0{
            continue
        }else{
            arrayOfTime.append("\(prayArray[i])")                           // arrayOfTime Array has 9 Elements which is the index
                                                                            // for every single pray arranged in indexes from 0 - 8 (5)
        }
    }
    print(arrayOfTime)
    
    var returnInt = 0                                                       // for Return
    for i in 0..<arrayOfTime.count{
        if (arrayOfTime[i].compare(currentTime(), options: .numeric) == .orderedDescending){
            returnInt = i
            break
        }
     }
    print(currentTime())
    return returnInt
}
