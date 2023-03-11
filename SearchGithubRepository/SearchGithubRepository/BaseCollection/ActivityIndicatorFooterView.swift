//
//  ActivityIndicatorFooterView.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/11.
//

import UIKit

final class ActivityIndicatorFooterView: UICollectionReusableView, BaseCollectionReusableView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func configure(item: BaseCollectionData) { }
}
