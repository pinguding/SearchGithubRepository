//
//  RootNavigationController.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/11.
//

import UIKit

final class RootNaivgationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController.build(viewModel: HomeViewModel())
        self.pushViewController(homeViewController, animated: false)
    }
}
