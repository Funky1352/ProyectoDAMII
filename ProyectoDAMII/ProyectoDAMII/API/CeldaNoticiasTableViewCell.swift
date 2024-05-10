//
//  CeldaNoticiasTableViewCell.swift
//  ProyectoDAMII
//
//  Created by DAMII on 9/05/24.
//

import UIKit

class CeldaNoticiasTableViewCell: UITableViewCell {

    @IBOutlet weak var titulolabel: UILabel!
    
    @IBOutlet weak var descripcionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
