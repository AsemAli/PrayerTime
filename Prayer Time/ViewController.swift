//
//  ViewController.swift
//  Prayer Time
//
//  Created by Asem Qaffaf on 8/25/18.
//  Copyright © 2018 Asem Qaffaf. All rights reserved.
//

import UIKit
import MapKit
import Foundation


struct prayerTime: Decodable {
    let data: [data]
    struct data: Decodable {
        let timings: timings
        let date: date
        let meta: meta
        struct timings: Decodable {
            let Fajr: String
            let Sunrise: String
            let Dhuhr: String
            let Asr: String
//            let Sunset: String
            let Maghrib: String
            let Isha: String
//            let Imsak: String
//            let Midnight: String
        }
        struct date: Decodable {
            let readable: String
              let hijri: hijri
            struct hijri: Decodable {
                let weekday: weekday
                let date: String
                struct weekday: Decodable {
                    let ar: String
            }
        }
    }
        struct meta: Decodable {
            let timezone: String
            let method: method
            struct method: Decodable {
                let name: String
            }
        }
    }
}

class ViewController: UIViewController, pickerRecive{

    let defaults = UserDefaults.standard

    var finalOutHeader: String = ""
    var finalOutOfPrayer: [String] = [String]()
    
    @IBOutlet var prayerTableView: UITableView!
    
    let PRAYER_URL = "http://api.aladhan.com/v1/calendar?"      // API Prpority
    var methodNumber: Int = 1
    
    
    
    var locationMan = CLLocationManager()                //Prpority
   var thownArr = [String]()
    
    @IBOutlet weak var prayerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiGetterPraysTimes(methodNumebr: methodNumber)
        
      if let items = defaults.array(forKey: "apiKey") as? [String]{
            finalOutOfPrayer = items
        }
        
        
    }

/*
    this function wokrs to
     1. fitch the API of prayer times with dynamic URL.
     2. handle the API base of the location and the date
     3. use --DispatchQueue.main.async-- in order to show the API result in the Label on the UI
*/
    func apiGetterPraysTimes(methodNumebr: Int) {
        
        /*
         print(locationGetter()[1])    -------------- invoke the function with Index ------------------
         print(timeGetter())or[0]      ---invoke the function with every element or call it by its Array's index---
 
        
        let jsonURL = "http://api.aladhan.com/v1/calendar?latitude=\(locationGetter()[0])&longitude=\(locationGetter()[1])&method=5&month=\(timeGetter()[1])&year=\(timeGetter()[2])"
       let url = URL(string: jsonURL)
    

         var PRAYER_URL = "http://api.aladhan.com/v1/calendar?   latitude=\(LATITUDE)&  longitude=\(LONGITUDE)&method="\(METHOD NUMBER)"&month=\(MONTH)&year=\(YEAR)"
         */
        
        //---------------------------------------------------------------------------------------------------------------------------//
        
        var backupURL = URLComponents(string: PRAYER_URL)
        
        backupURL?.queryItems = [
            URLQueryItem(name: "latitude", value: "\(locationGetter()["lat"]!)"),
            URLQueryItem(name: "longitude", value: "\(locationGetter()["long"]!)"),
            URLQueryItem(name: "method", value: "\(methodNumebr)"),
            URLQueryItem(name: "month", value: "\(timeGetter()["month"]!)"),
            URLQueryItem(name: "year", value: "\(timeGetter()["year"]!)")

        ]
        let urlType = backupURL?.url
        
        URLSession.shared.dataTask(with: urlType!){
            (data, responds, Error) in
            
            do{
                let p = try JSONDecoder().decode(prayerTime.self, from: data!)
                
                let arr = p.data     // this API array goes in the properity to see its [data]
                
                
                /*
                 1. print(arr.count)          the count of the API's array
                 2. use the array of date
                 3. here we explicitly the timeGetter method with index 0 which is for the day and the we subtract 1 in order to get TODAY
                 4. we fitch the data here from the Array in the line 70
                 */
                
                let timeingPray = arr[self.timeGetter()["day"]!-1].timings                   // get today's date from timeGetter func
                let gregorianDate = arr[self.timeGetter()["day"]!-1].date.readable           // get today's date from timeGetter func
                let datePray = arr[self.timeGetter()["day"]!-1].date.hijri.date              // get today's date from timeGetter func
                let weekDayPray = arr[self.timeGetter()["day"]!-1].date.hijri.weekday.ar     // get today's date from timeGetter func
                let timeZone = arr[self.timeGetter()["day"]!-1].meta.timezone                // get today's date from timeGetter func
                let methodName = arr[self.timeGetter()["day"]!-1].meta.method.name           // get today's date from timeGetter func
                
                self.finalOutHeader =
//                "CurrentTime: \(currentTime())\n\n" +
                         "Date: \(gregorianDate)\n\n"
                        + "Hijri Date: \(datePray)\n\n"
                        + "Week Day: \(weekDayPray)\n\n"
                        + "Time Zone: \(timeZone)\n\n"
                        + "\(methodName)\n\n"
                 self.finalOutOfPrayer =
                    [ "Fajr: \(timeingPray.Fajr)\n\n"                           //Fajr Index in finalOutOfPrayer Array is:     0
                        , "Sunrise: \(timeingPray.Sunrise)\n\n"                 //Sunrise Index in finalOutOfPrayer Array is:  1
                        , "Dhuhr: \(timeingPray.Dhuhr)\n\n"                     //Dhuhr Index in finalOutOfPrayer Array is:    2
                        , "Asr: \(timeingPray.Asr)\n\n"                         //Asr Index in finalOutOfPrayer Array is:      3
//                        , "Sunset: \(timeingPray.Sunset)\n\n"                 //Sunset Index in finalOutOfPrayer Array is:   4
                        , "Maghrib: \(timeingPray.Maghrib)\n\n"                 //Maghrib Index in finalOutOfPrayer Array is:  5
                        , "Isha: \(timeingPray.Isha)"]                          //Isha Index in finalOutOfPrayer Array is:     6
//                        , "Imsak: \(timeingPray.Imsak)\n\n"                   //Imsak Index in finalOutOfPrayer Array is:    7
//                        , "Midnight: \(timeingPray.Midnight)\n"]              //Midnight Index in finalOutOfPrayer Array is: 8
              
                
        //////////////////////////////////////////////// CAUTION DO NOT CHANGE///////////////////////////////////////////////////////
                var FinalOutStrWithoutChanges = ""
                for i in self.finalOutOfPrayer{
                    FinalOutStrWithoutChanges += i            // String concatinate in order to send its value to calculatePrayTime
                }
                let finalOfPrayerSplited = FinalOutStrWithoutChanges.split(separator: " ") // send finalOfPrayerSplited as String.sequance to calculatePrayTime Func
                let indexOfChange = caculatePrayTime(prayArray: finalOfPrayerSplited)
                
        //////////////////////////////////////////////////////////// END ////////////////////////////////////////////////////////////

                
                var strFinalOut = ""

                for i in 0..<self.finalOutOfPrayer.count{
                    if i == indexOfChange  { ////////// indexOfChange is the result of the calculatePrayTime Array @Para Int
                     
                        strFinalOut += "next--> \(self.finalOutOfPrayer[i])"
   

                    }else if i != indexOfChange{
                        strFinalOut += self.finalOutOfPrayer[i]
                }
            }
                

//                print(strFinalOut)               //   --------------Print the API-----------------
                /*
                 self.prayerLabel.text = "\(finalOut)"    ----here's an error to display the API data to UI label-----
                 
                                            ----------here we use DispatchQueue.main.async----------
                 */
               
                self.arrayReciver(arr: self.finalOutOfPrayer)
                
                self.defaults.set("\(self.finalOutOfPrayer) \(self.finalOutOfPrayer)", forKey: "apiKey")
                DispatchQueue.main.async {
                    self.prayerLabel.text = "\(self.finalOutHeader) \(strFinalOut)"
                }
              
            }
            catch let jsonErr{
                print(jsonErr)
            }
            
            }.resume()
        
        
        self.prayerLabel.text = "Loding...\n تحميل "
       
    
    }
    
 


    // this function allows us to get the latitude and longitude of the device  ---this functions needs permission---
    func locationGetter() -> [String:Double] {
//       locationMan.delegate = self as? CLLocationManagerDelegate
//        locationMan.requestWhenInUseAuthorization()
//        locationMan.desiredAccuracy = kCLLocationAccuracyKilometer
//        locationMan.startUpdatingLocation()
//        locationMan.startMonitoringSignificantLocationChanges()
//
//        // here you can whether you have allowed the permission of not!
//
//        if CLLocationManager.locationServicesEnabled(){
//            switch (CLLocationManager.authorizationStatus()){
//
//            case .notDetermined:
//                print("Do not Determind")
//            case .restricted:
//                print("Access restricted")
//            case .denied:
//                print("Access Denied")
//            case .authorizedAlways, .authorizedWhenInUse:
//                print("Authorized")
//                let latitude: CLLocationDegrees = ((locationMan.location?.coordinate.latitude)!)
//                let longitude: CLLocationDegrees = ((locationMan.location?.coordinate.longitude)!)
///*
//                 both of latitude and longitude
//            ***     let location = CLLocation(latitude: latitude, longitude: longitude) ****
//*/
//                let  arrOfLatAndLong = ["lat" : latitude ,"long" : longitude]
//
//                return arrOfLatAndLong
//
//            }
//        }
//

        let diffultArr = ["lat" : 21.3891 ,"long" : 39.8579] // mecca's time

        return diffultArr

    }

    // This function gives the Date, Month and the year in Array of Integer day index 0, month index 1, year index 2
    func timeGetter() -> [String:Int] {
        var arrOfDate = [String:Int]()

        let date = Date()

        let dateFormat = DateFormatter()

        //---------Day Getter from dateFormat---------

        dateFormat.dateFormat = "dd"
        let dayStr = dateFormat.string(from: date)          // from date in the line 183 which is today's date ********<let date = Date()>**********
        let dayInt = Int(dayStr)    // cast to Int

//        arrOfDate.append(dayInt!)   // day index 0
        arrOfDate.updateValue(dayInt!, forKey: "day")           // key day
        //---------Month Getter from dateFormat---------

        dateFormat.dateFormat = "Month"
        let MonthStr = dateFormat.string(from: date)    // from date in the line 183 which is today's date  ********<let date = Date()>**********
        let monthInt = Int(MonthStr)    //cast to Int

//        arrOfDate.append(monthInt!)   // month index 1
        arrOfDate.updateValue(monthInt!, forKey: "month")       // key month

        //---------Year Getter from dateFormat-----------


        dateFormat.dateFormat = "yyyy"
        let yearStr = dateFormat.string(from: date)   // from date in the line 183 which is today's date    ********<let date = Date()>**********
        let yearInt = Int(yearStr)      // cast to Int

//        arrOfDate.append(yearInt!)  // year index 2
        arrOfDate.updateValue(yearInt!, forKey: "year")         //key year



        return arrOfDate
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondVC"{
            let aaa = segue.destination as! SecoundViewController
            aaa.pickerDelegate = self
        }
    }

    func pickerReiverMethod(index: Int) {
        print(index)
        methodNumber = index
        apiGetterPraysTimes(methodNumebr: methodNumber)
    }
    
    func arrayReciver(arr: [String])  {
        
        thownArr = arr
 
    }
    

    
   
    func configtabelView()  {
        prayerTableView.rowHeight = UITableView.automaticDimension
        prayerTableView.estimatedRowHeight = 12.0
    }
}
