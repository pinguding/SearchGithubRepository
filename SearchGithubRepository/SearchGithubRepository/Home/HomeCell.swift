//
//  HomeCell.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/11.
//

import UIKit

final class HomeCell: UICollectionViewCell, BaseCollectionViewCell {
    
    weak var controlEventDelegate: BaseCollectionUIControlEventDelegate? = nil

    @IBOutlet weak var titleLabel: UILabel!
    
    var indexPath: IndexPath? = nil
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    func configure(item: BaseCollectionData, indexPath: IndexPath) {
        titleLabel.text = item.title
        self.indexPath = indexPath
    }
}
