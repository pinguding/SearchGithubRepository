//
//  BaseCollectionViewController.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/08.
//

import UIKit

open class BaseCollectionViewController: UIViewController {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    open var cells: [BaseCollectionViewCell] {
        []
    }
    
    open var header: BaseCollectionReusableView? {
        nil
    }
    
    open var numberOfSections: Int {
        1
    }
    
    public private(set) weak var viewModel: BaseCollectionViewModel?
    
    static public func build<ViewModel: BaseCollectionViewModel>(viewModel: ViewModel) -> BaseCollectionViewController {
        let identifier = String(describing: Self.self)
        let viewController = UIStoryboard(name: identifier, bundle: .main).instantiateViewController(withIdentifier: identifier) as! Self
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        cells.forEach {
            let cellType = type(of: $0)
            collectionView.register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
        }
        
        if let header = header {
            let headerType = type(of: header)
            collectionView.register(headerType.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerType.identifier)
        }
    }
    
    
    
    open func sinkWithViewModel() {
        
    }
}
