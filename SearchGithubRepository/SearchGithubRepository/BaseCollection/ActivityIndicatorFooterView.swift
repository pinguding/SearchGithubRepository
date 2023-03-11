//
//  ActivityIndicatorFooterView.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/11.
//

import UIKit

final class ActivityIndicatorFooterView: UICollectionReusableView, BaseCollectionReusableView {
    
    var indexPath: IndexPath?    
    
    weak var controlEventDelegate: BaseCollectionUIControlEventDelegate? = nil
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func configure(item: BaseCollectionData, indexPath: IndexPath) {
        self.indexPath = indexPath
    }
}
