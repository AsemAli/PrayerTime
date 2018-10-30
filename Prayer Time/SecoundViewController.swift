//
//  SecoundViewController.swift
//  Prayer Time
//
//  Created by Asem Qaffaf on 9/21/18.
//  Copyright © 2018 Asem Qaffaf. All rights reserved.
//

import UIKit
protocol pickerRecive {
    func pickerReiverMethod(index: Int)
}

class SecoundViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {
  
    var arrayOfPrayerMethod = [String]()
    var pickerDelegate: pickerRecive?
    var number = 0
    /*
     Shia Ithna-Ansari
     1 - University of Islamic Sciences, Karachi
     2 - Islamic Society of North America
     3 - "Muslim World League"
     4 - "Umm Al-Qura University, Makkah"//
     5 - "Egyptian General Authority of Survey"
     7 - "Institute of Geophysics, University of Tehran"
     8 - "Gulf Region"
     9 - Kuwait
     10 - Qatar
     11 - Majlis Ugama Islam Singapura, Singapore
     12 - Union Organization islamic de France
     13 - Diyanet İşleri Başkanlığı, Turkey
 */
    
    @IBOutlet weak var labelOfPickerView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfPrayerMethod = ["University of Islamic Sciences, Karachi",
                               "Islamic Society of North America",
                               "Muslim World League",
                               "Umm Al-Qura University, Makkah" ,
                               "Egyptian General Authority of Survey",
                               "Islamic Society of North America",
                               "Institute of Geophysics, University of Tehran" ,
                               "Gulf Region" , "Kuwait" , "Qatar" ,
                               "Majlis Ugama Islam Singapura, Singapore" ,
                               "Union Organization islamic de France",
                               "Diyanet İşleri Başkanlığı, Turkey"]
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        // Do any additional setup after loading the view.
    }
    // MARK: Pickerview method

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfPrayerMethod.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfPrayerMethod[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         number = row + 1
        self.labelOfPickerView.text = arrayOfPrayerMethod[row]
        
    }
    

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func submitButton(_ sender: UIButton) {
        
        pickerDelegate?.pickerReiverMethod(index: number)
        self.dismiss(animated: true, completion: nil)
    }
    
}
