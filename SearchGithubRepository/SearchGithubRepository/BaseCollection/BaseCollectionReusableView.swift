//
//  BaseCollectionReusableView.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/09.
//

import UIKit

public protocol BaseCollectionReusableView: UICollectionReusableView {
    
    static var identifier: String { get }
    
    static var nib: UINib { get }
    
    func configure(item: BaseCollectionData)
}

public extension BaseCollectionReusableView {
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    static var nib: UINib {
        UINib(nibName: Self.identifier, bundle: .main)
    }
}
