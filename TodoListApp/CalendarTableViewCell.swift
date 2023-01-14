//
//  CalendarTableViewCell.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2022/12/01.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var todoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
}
