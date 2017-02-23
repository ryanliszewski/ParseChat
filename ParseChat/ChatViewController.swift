//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Ryan Liszewski on 2/22/17.
//  Copyright © 2017 Smiley. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [PFObject]?
    
    var messageText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.refreshMessages), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendMessageButton(_ sender: Any) {
        let pfMessage = PFObject(className: "Message")
        
         pfMessage["text"] = messageTextField.text
        
        //pfMessage.add(messageText, forKey: "text")
        
        pfMessage.saveInBackground { (success: Bool, error: Error?) in
            if(success){
                print("The message has been sent")
            } else{
                print("ERROR! THe message was not sent")
            }
        }
    }
    
    func refreshMessages(){
        let query = PFQuery(className: "Message")
        query.whereKeyExists("text")
        
        
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) in
            
            self.messages = messages
            
            if(error == nil){
                for message in self.messages! {
                    print(message)
                    self.tableView.reloadData()
                }
            }else {
                print("Error retrieving messages")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        return cell 
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
