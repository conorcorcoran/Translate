//
//  ViewController.swift
//  Translate
//
//  Created by Robert O'Connor on 16/10/2015.
//  Copyright © 2015 WIT. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet weak var languagePicker: UIPickerView!
    
    var languageArray = ["French", "Turkish", "Irish"]
    
    
    var languageCode: [String: String] = ["en": "English", "fr": "French", "tr": "Turkish", "ga": "Irish"] //Key: Value
    
    //var data = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagePicker.delegate = self
        languagePicker.dataSource = self
        
        
        textToTranslate.text = "Enter text to translate"
        textToTranslate.textColor = UIColor.black
        textToTranslate.font = UIFont(name: "Palatino", size: 17)
        
        
        
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        textToTranslate.resignFirstResponder()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return languageArray.count 
    }
    
    func textToTranslateDidBeginEditing(textView: UITextView)
    {
        if textToTranslate.textColor == UIColor.lightGray
        {
            textToTranslate.text = nil
            textToTranslate.textColor = UIColor.black
        }
    }
    
    func textToTranslateDidEndEditing(textView: UITextView)
    {
        if textToTranslate.text.isEmpty{
            textView.textColor = UIColor.black
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: languageArray[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    
    var preferredLanguage = NSLocale.current.languageCode!
    
    var translatingLanguage = ""
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
         translatingLanguage = "fr"
        }
        else if(row == 1)
        {
          translatingLanguage = "tr"
        }
        else if(row == 2)
        {
         translatingLanguage = "ga"
        }
        else
        {
           translatingLanguage = "en"
        }
    }
    
    
    @IBAction func translate(_ sender: AnyObject) {
        
        let str = textToTranslate.text
        let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let langStr = (preferredLanguage + "|" + translatingLanguage).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
        
        let url = URL(string: urlStr)
        
        let request = URLRequest(url: url!)// Creating Http Request
        
        //var data = NSMutableData()var data = NSMutableData()
        
        
        EZLoadingActivity.show("Translating...", disableUI: true)
        
        var result = "<Translation Error>"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
            
           EZLoadingActivity.hide(true, animated: true)
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 200){
                    
                    let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                    
                    if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
                        let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
                        
                        result = responseData.object(forKey: "translatedText") as! String
                    }
                }
                
                self.translatedText.text = result
            }
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
}
