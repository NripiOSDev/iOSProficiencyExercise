//
//  RootViewController.swift
//  InterviewAssignment
//
//  Created by Nripendra singh on 13/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

class RootViewController: UIViewController {
    
    var isReachableConnection: Bool = false
    var listTableview: UITableView!
    var messageLabel: UILabel = UILabel()
    var arrDataTest = [String]()
    var arrDataList = [CanadaInfoModel.CanadaData]()
    var rootViewModel = RootViewModel()
    let network: NetworkManager = NetworkManager.sharedInstance
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(RootViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .red
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.checkInternetConnection()
        rootViewModel.delegate = self
        self.setupTableView()
    }
    
    func checkInternetConnection() -> Void{
        NetworkManager.isUnreachable { _ in
            self.showOfflinePage()
        }
        
        NetworkManager.isReachable { _ in
            self.showMainPage()
        }
        network.reachability.whenUnreachable = { reachability in
            self.showOfflinePage()
        }
    }

    // MARK: -  Setup TableView
    func setupTableView() -> Void{
        listTableview = UITableView()
        listTableview.dataSource = self
        listTableview.separatorStyle = .none
        listTableview.estimatedRowHeight = CGFloat(Constant.TableViewKeys.cellEstimatedHeight)
        listTableview.rowHeight = UITableView.automaticDimension
        listTableview.register(listTableViewCell.self, forCellReuseIdentifier:Constant.TableViewKeys.cellReuseIdentifier)
        self.view.addSubview(listTableview)
        self.listTableview.addSubview(self.refreshControl)
        
        listTableview.translatesAutoresizingMaskIntoConstraints = false
        listTableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        listTableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        listTableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        listTableview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        messageLabel.textAlignment = .center
        messageLabel.text = Constant.DefaultValue.tableviewEmptyMessage
        messageLabel.numberOfLines=1
        messageLabel.textColor = .lightGray
        messageLabel.font = UIFont.systemFont(ofSize: 22)
        messageLabel.isHidden = true
        self.view.addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        //messageLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        //messageLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: messageLabel.superview!.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: messageLabel.superview!.centerYAnchor).isActive = true
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) -> Void{
        DispatchQueue.main.async {
            self.messageLabel.isHidden = true
            self.apiCallForData()
        }
        refreshControl.endRefreshing()
    }
    
    // MARK: -  Api call method
    func apiCallForData() -> Void {
        self.showHud(Constant.LoaderMessage.message)
        rootViewModel.getImagesData(apiUrl: Constant.ApiUrls.baseUrl)
    }
    
    // MARK: -  Reachability methods
    private func showOfflinePage() -> Void {
        let alertView = UIAlertController(title: Constant.ErrorMessage.messageTitle, message: Constant.ErrorMessage.messageText, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: Constant.ErrorMessage.messageActionText, style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
        
        DispatchQueue.main.async {
            self.arrDataList.removeAll()
            self.listTableview.reloadData()
            self.messageLabel.isHidden = false
        }
        self.isReachableConnection = false
    }
    
    private func showMainPage() -> Void {
        DispatchQueue.main.async {
            self.apiCallForData()
        }
        self.isReachableConnection = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource
extension RootViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrDataList.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.TableViewKeys.cellReuseIdentifier, for: indexPath) as! listTableViewCell
        cell.selectionStyle = .none
        if (arrDataList.count > 0) {
            let model = arrDataList[(indexPath as NSIndexPath).row]
            cell.lblTitle.text = model.title
            cell.lblDescription.text = model.description
            let url = URL(string: model.imageUrl)
            let image = UIImage(named: "placeholder.png")
            cell.imgUser.kf.setImage(with: url, placeholder: image)
        }
        
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

// MARK: - ViewModel method
extension RootViewController : RootViewModelDelegate {
    func rootViewModelRecieveData(_ infoData: [CanadaInfoModel.CanadaData], _ navigattionTitle: String, _ error: String) {
        if (error != Constant.ErrorMessage.messageText) {
            self.arrDataList = infoData
            DispatchQueue.main.async {
                self.title = navigattionTitle
                self.listTableview.reloadData()
                self.hideHUD()
            }
        }
        else{
            let alertView = UIAlertController(title: Constant.ErrorMessage.messageTitle, message: Constant.ErrorMessage.messageText, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: Constant.ErrorMessage.messageActionText, style: .default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }
    }
}
