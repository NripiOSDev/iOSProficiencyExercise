//
//  ViewController.swift
//  InterviewAssignment
//
//  Created by Nripendra singh on 13/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listTableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        listTableview = UITableView()
        listTableview.backgroundColor = .cyan
        self.view.addSubview(listTableview)
        
        listTableview.translatesAutoresizingMaskIntoConstraints = false
        listTableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        listTableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        listTableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        listTableview.topAnchor.constraint(equalTo:self.view.topAnchor).isActive = true

    }
    
    //PRAGMAMARK:- Api used to call get Data
    func call(apiUrl: String) -> Void{
        
        ServiceManager.sharedInstance.getallDataFromApi(contenturl: "", postCompleted: { (responseData, responseCode) in
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
}

