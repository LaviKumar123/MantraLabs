//
//  MenuTableViewCell.swift
//  MantraLabs
//
//  Created by APPLE on 25/02/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var subCategoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
