//
//  HomeViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 08/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//
import UIKit


class HomeViewController: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var welcomeUser: UILabel!
    
    @IBOutlet weak var classRightNow: UILabel!
    
    
    //Actions
    
    @IBAction func logOut(_ sender: UIButton) {
        //logout user
    }
    
    
    
    //Functions
    
    func retrieveSchedule() -> Array<String>{
        return ["Piet Janssen", "Natuurkunde", "F201"]
    }
    
    func convertJSON(data: Data, key: String, index: Int) -> Any{
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any]{

                return object[key]
            }else if let object = json as? [Any]{
                print(object[index])
                return object[index]
            }else{
                print("JSON Invalid")
                return "Oops"
            }
        }catch{
            print(error)
            return "Oops"
        }

    }
    
    func getAllData(studentCode: String, startTime: String, endTime: String){
        
        let defaults = UserDefaults.standard
        
        let domainName = defaults.value(forKey: "Domain name") as! String
        
        var schedule = Array<Dictionary<String,String>>()
        
        
        if let accesToken = (defaults.value(forKey: "Accestoken") as? String){
            print(accesToken)
            let url = URL(string: "https://"+domainName+".zportal.nl/api/v3/appointments?user="+studentCode+"&start="+startTime+"&end="+endTime+"&access_token="+accesToken)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let json = self.convertJSON(data: data, key: "response", index: 0)
                if let schedule = json as? Dictionary<String, Any>{
                    let totalSchedule = schedule["data"]! as! Array<Dictionary<String, Any>>
                    for x in 0..<totalSchedule.count{
                        let lesson = totalSchedule[x]
                        
                        print(lesson)
                        
                        let teacher = lesson["teachers"] as! NSArray
                        let subject = lesson["subjects"] as! NSArray
                        let location = lesson["locations"] as! NSArray
                        
                        let remark = lesson["remark"] as! String
                        let changeDescription = lesson["changeDescription"] as! String
                        
                        let modified = lesson["modified"] as! Int
                        let moved = lesson["moved"] as! Int
                        let cancelled = lesson["cancelled"] as! Int
                        let new = lesson["new"] as! Int
                        let hour = lesson["endTimeSlot"] as! Int
                        
                        
                        
                    }
                }
                

                
            }
            task.resume()
            
        }else{
            let activationCode = defaults.value(forKey: "Activation code") as! String
            let url = URL(string: "https://driestarcollege.zportal.nl/api/v3/oauth/token")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let postString = "grant_type=authorization_code&code="+activationCode
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
                print(self.convertToDictionary(text: responseString!)!)
                print(self.convertToDictionary(text: responseString!)!["access_token"]!)
                
                if let accestoken = self.convertToDictionary(text: responseString!)!["access_token"] as? String{

                    //Accestoken saving
                    defaults.set(accestoken, forKey: "Accestoken")
                    
                    let url = URL(string: "https://driestarcollege.zportal.nl/api/v3/appointments?user="+studentCode+"&start="+startTime+"&end="+endTime+"&access_token="+accestoken)!
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data, error == nil else {
                            // check for fundamental networking error
                            print("error=\(String(describing: error))")
                            return
                        }
                        
                        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                            // check for http errors
                            print("statusCode should be 200, but is \(httpStatus.statusCode)")
                            print("response = \(String(describing: response))")
                        }
                        
                        let responseString = String(data: data, encoding: .utf8)
                        print("responseString = \(String(describing: responseString))")
                        
                        let schedule = self.convertToDictionary(text: responseString!)
                        print(schedule!)
                    }
                    task.resume()
                }
                
            }
            task.resume()
        }
        
    }
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let schedule = retrieveSchedule()
        
        let timeRightNow = Int(NSDate().timeIntervalSince1970)
        
        let startTime = timeRightNow
        let endTime = timeRightNow + 21*24*3600
        
        getAllData(studentCode: "163250", startTime: String(startTime), endTime: String(endTime))
        
        welcomeUser.text = "Welcome, " + schedule[0]
        classRightNow.text = "You have " + schedule[1] +  ", in " + schedule[2]
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
