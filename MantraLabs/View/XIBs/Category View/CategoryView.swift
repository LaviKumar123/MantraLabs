//
//  CategoryView.swift
//  MantraLabs
//
//  Created by APPLE on 25/02/21.
//

import Foundation
import UIKit

class CategoryView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryIconView: UIImageView!
    @IBOutlet weak var upDownArrow: UIImageView!
    
    var completion : ((String)->())!
    
    class func loadView()-> CategoryView {
        
        let containerView =  UINib(nibName: "\(self)", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CategoryView
        
        containerView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 46)
        
        return containerView!
    }
    
    //MARK:- Button Action
    @IBAction func sectionTapped(_ sender: UIButton) {
        self.completion("Tapped")
    }
}
