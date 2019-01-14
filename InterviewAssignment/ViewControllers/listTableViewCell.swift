//
//  listTableViewCell.swift
//  InterviewAssignment
//
//  Created by Nripendra singh on 13/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//


import UIKit

class listTableViewCell: UITableViewCell {
    
    let imgUser = UIImageView()
    let lblTitle = UILabel()
    let lblDescription = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupAllSubViews()
    }
    
    // MARK: - Setup custom cell all subviews
    func setupAllSubViews() -> Void{
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(imgUser)
        imgUser.contentMode = .scaleAspectFit
        imgUser.translatesAutoresizingMaskIntoConstraints = false
        imgUser.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        imgUser.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        imgUser.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        imgUser.heightAnchor.constraint(greaterThanOrEqualToConstant:180).isActive = true
        
        // configure titleLabel
        contentView.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        lblTitle.topAnchor.constraint(equalTo: imgUser.bottomAnchor).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        lblDescription.font = UIFont(name: "Helvetica", size: 19)
        lblTitle.numberOfLines = 0
        
        // configure titleLabel
        contentView.addSubview(lblDescription)
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        lblDescription.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        lblDescription.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        lblDescription.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
        lblDescription.numberOfLines = 0
        lblDescription.font = UIFont(name: "Helvetica", size: 16)
        lblDescription.textColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
