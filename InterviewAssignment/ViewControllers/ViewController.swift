//
//  ViewController.swift
//  InterviewAssignment
//
//  Created by Nripendra singh on 13/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD
class ViewController: UIViewController {
    
    var listTableview: UITableView!
    var arrDataList = [CanadaInfoModel.CanadaData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupTableView()
        self.getImagesData(apiUrl: Constant.ApiUrls.baseUrl)
    }
    
    // MARK: -  Setup TableView
    func setupTableView() -> Void{
        listTableview = UITableView()
        listTableview.dataSource = self
        listTableview.separatorStyle = .none
        listTableview.estimatedRowHeight = CGFloat(Constant.TableViewKeys.cellEstimatedHeight)
        listTableview.rowHeight = UITableViewAutomaticDimension
        listTableview.register(listTableViewCell.self, forCellReuseIdentifier:Constant.TableViewKeys.cellReuseIdentifier)
        self.view.addSubview(listTableview)
        
        listTableview.translatesAutoresizingMaskIntoConstraints = false
        listTableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        listTableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        listTableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        listTableview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }
    
    // MARK: - Api call for geting data
    func getImagesData(apiUrl: String) -> Void{
        self.showHud(Constant.LoaderMessage.message)
        ServiceManager.sharedInstance.getallDataFromApi(contenturl:apiUrl, getCompleted: { (responseData, responseCode) in
            
            if responseCode == Constant.ApiResponseCode.Success{
                if let responseDictDataArray = responseData[Constant.ApiKeys.rows] as? [[String : AnyObject]]{
                    self.title = responseData[Constant.ApiKeys.title] as? String
                    var model = [CanadaInfoModel.CanadaData]()
                    model = responseDictDataArray.compactMap{ (dictionary) in
                        return CanadaInfoModel.CanadaData(dictionary)
                    }
                    self.arrDataList = model
                }
                DispatchQueue.main.async {
                    self.listTableview.reloadData()
                    self.hideHUD()
                }
            }
            else{
                let alertView = UIAlertController(title: Constant.ErrorMessage.messageTitle, message: Constant.ErrorMessage.messageText, preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: Constant.ErrorMessage.messageActionText, style: .default, handler: nil))
                self.present(alertView, animated: true, completion: nil)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.TableViewKeys.cellReuseIdentifier, for: indexPath) as! listTableViewCell
        let model = arrDataList[(indexPath as NSIndexPath).row]
        cell.lblTitle.text = model.title
        cell.lblDescription.text = model.description
        let url = URL(string: model.imageUrl)
        let image = UIImage(named: "placeholder.png")
        cell.imgUser.kf.setImage(with: url, placeholder: image)
        
        return cell
    }
}

// MARK: - Progress hud methods
extension UIViewController {
    func showHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.animationType = .zoomOut
        hud.mode = MBProgressHUDMode.indeterminate
        hud.bezelView.backgroundColor = UIColor.clear
        hud.bezelView.style = .blur
        hud.isUserInteractionEnabled = true
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}


