//
//  ViewController.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/08.
//

import UIKit

final class HomeViewController: BaseCollectionViewController {

    override var cells: [Int : BaseCollectionViewCell.Type] {
        [0: HomeCell.self]
    }
    
    override var header: [Int : BaseCollectionReusableView.Type] {
        [:]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

