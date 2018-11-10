//
//  noteTableViewCell.swift
//  Notes
//
//  Created by Asgedom Teklu on 11/9/18.
//  Copyright © 2018 Asgedom Y. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var noteNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //style
        shadowView.layer.shadowColor = UIColor(red: 245.0/255.0, green: 79.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0.75 , height: 0.75)
        shadowView.layer.shadowRadius = 1.5
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.cornerRadius = 2
        
        noteImageView.layer.cornerRadius = 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(note: Note){
        self.noteNameLabel.text = note.noteName?.uppercased()
        self.descriptionLabel.text = note.description
        self.noteImageView.image = UIImage (data: note.noteImage! as Data)
    }
    

}
