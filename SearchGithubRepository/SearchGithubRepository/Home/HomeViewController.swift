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
    
    override var sectionId: [Int] {
        [0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
    }
    
    
}

