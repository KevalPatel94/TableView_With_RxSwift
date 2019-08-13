//
//  ListCell.swift
//  Table
//
//  Created by Keval Patel on 8/6/19.
//  Copyright © 2019 Keval Patel. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    var channelViewModel : ChannelViewModel!{
        didSet{
            lblName.text = "\(channelViewModel.title)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
