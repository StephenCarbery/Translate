//
//  ViewController.swift
//  Translate
//
//  Created by Robert O'Connor on 16/10/2015.
//  Copyright © 2015 WIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet weak var selectLanguage: UIPickerView!
    @IBOutlet weak var destLangImageView: UIImageView!
    @IBOutlet weak var langText: UITextView!
    
    let langPicker = ["French", "Spanish", "German"]
    var langSelect = ""
    
    
    
    
    //var data = NSMutableData()
    
    //Number of columns of languages
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langPicker.count
    }
    
    //Recieves the specific row and specific component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return langPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        langSelect = langPicker[row]
        self.langText.text = langSelect
        switch langSelect {
        case "French" :
            destLangImageView.image = UIImage(named: "France-96")
        case "German" :
            destLangImageView.image = UIImage(named: "Germany-96")
        case "Spanish" :
            destLangImageView.image = UIImage(named: "Spain 2-96")
        default :
            destLangImageView.image = UIImage(named: "France-96")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textToTranslate.delegate = self
        self.selectLanguage.delegate = self
        self.selectLanguage.dataSource = self
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView){
        textToTranslate.text = ""
    }
    
    
    @IBAction func translate(_ sender: AnyObject) {
        
        
        let str = textToTranslate.text
        let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var langpair = ""
        switch langSelect {
            case "French" :
                langpair = "en|fr"
            case "German" :
                langpair = "en|de"
            case "Spanish" :
                langpair = "en|es"
            default :
                langpair = "en|fr"
        }
        let langStr = (langpair).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
        
        let url = URL(string: urlStr)
        
        let request = URLRequest(url: url!)// Creating Http Request
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        //var data = NSMutableData()var data = NSMutableData()
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        var result = "<Translation Error>"
        
        
        
        
        //NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) 
            let task = session.dataTask(with: request){ data, response, error in
            
            
                if let httpResponse = response as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                    
                    let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                    
                    if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
                        let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
                        
                        result = responseData.object(forKey: "translatedText") as! String
                    }
                }
            }
            DispatchQueue.main.async{
                self.translatedText.text = result
                indicator.stopAnimating()

            }
        }
        task.resume()
    }
}

