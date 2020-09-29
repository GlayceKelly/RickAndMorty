//
//  CharactersTableViewCell.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 29/09/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import UIKit
import Kingfisher

class CharactersTableViewCell: UITableViewCell {

    //*************************************************
    // MARK: - IBOutlets
    //*************************************************
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var episodiesButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //*************************************************
    // MARK: - IBActions
    //*************************************************
    
    @IBAction func fetchEpiodies(_ sender: UIButton) {
    }
    
}

//*************************************************
// MARK: - Public methods
//*************************************************

extension CharactersTableViewCell {
    func prepareCell(with result: Results) {
        nameLabel.text = result.name
        statusLabel.text = result.status
        
        let url = URL(string: result.image)
        avatarImageView.kf.setImage(with: url)
    }
}
