//
//  BaseCollectionViewController.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/08.
//

import UIKit
import Combine

open class BaseCollectionViewController: UIViewController {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    open var cells: [BaseCollectionViewCell] {
        []
    }
    
    open var header: BaseCollectionReusableView? {
        nil
    }
    
    open var usingPagination: Bool {
        false
    }
    
    public private(set) weak var viewModel: BaseCollectionViewModel?
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, BaseCollectionData>?
    
    private var cancellable: Set<AnyCancellable> = []
    
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
        
        sinkWithViewModel()
    }
    
    open func sinkWithViewModel() {
        viewModel?.updateDataSourcePublisher
            .sink(receiveValue: { [weak self] _ in
                DispatchQueue.main.async {
                    guard let self = self, let viewModel = self.viewModel else { return }
                    var snapShot = NSDiffableDataSourceSnapshot<Int, BaseCollectionData>()
                    snapShot.appendSections([0])
                    snapShot.appendItems(viewModel.collectionViewDataSource)
                    self.dataSource?.apply(snapShot)
                }
            })
            .store(in: &cancellable)
    }
}
