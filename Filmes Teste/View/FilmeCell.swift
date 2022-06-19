//
//  FilmeCell.swift
//  Filmes Teste
//
//  Created by Francisco Neto on 11/06/22.
//

import UIKit

class FilmeCell: UITableViewCell {

    @IBOutlet weak var labelNomeFilme: UILabel!
    @IBOutlet weak var labelNotaImdb: UILabel!
    @IBOutlet weak var labelUpDown: UILabel!
    
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var labelRank: UILabel!
    @IBOutlet weak var imageFilme: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
