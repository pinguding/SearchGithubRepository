//
//  BaseCollectionViewCell.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/08.
//

import UIKit

public protocol BaseCollectionViewCell: BaseCollectionReusableView, UICollectionViewCell {
    
    var indexPath: IndexPath { get }
    
    func configure(item: BaseCollectionData)
}
