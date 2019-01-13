//
//  listTableViewCell.swift
//  InterviewAssignment
//
//  Created by Nripendra singh on 13/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//

import UIKit

class listTableViewCell: UITableViewCell {
    
    var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.labelSetupCode()
    }
    
    func labelSetupCode() {
        label = UILabel(frame: contentView.frame)
        contentView.addSubview(label)
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 12)
        self.contentView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
