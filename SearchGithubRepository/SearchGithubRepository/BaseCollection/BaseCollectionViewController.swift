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
    
    open var cells: [Int: BaseCollectionViewCell.Type] {
        [:]
    }
    
    open var numberOfSection: Int {
        0
    }
    
    open var header: [Int: BaseCollectionReusableView.Type] {
        [:]
    }
    
    open var showActivityIndicatorFooter: Bool {
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
            collectionView.register($0.value.nib, forCellWithReuseIdentifier: $0.value.identifier)
        }
        
        header.forEach {
            collectionView.register($0.value.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: $0.value.identifier)
        }
        
        if showActivityIndicatorFooter {
            collectionView.register(ActivityIndicatorFooterView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ActivityIndicatorFooterView.identifier)
        }
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, environment in
            let sectionLayout = self.collectionViewCompositionalSectionLayout(at: sectionIndex)
            
            var boundarySupplementaryItems = sectionLayout.boundarySupplementaryItems
            
            if self.showActivityIndicatorFooter, sectionIndex == self.numberOfSection - 1 {
                let footerLayout = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
                boundarySupplementaryItems.append(footerLayout)
            }
            
            sectionLayout.boundarySupplementaryItems = boundarySupplementaryItems
            
            return sectionLayout
        })
        
        dataSource = UICollectionViewDiffableDataSource<Int, BaseCollectionData>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cellType = self.cells[indexPath.section],
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? BaseCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.controlEventDelegate = self
            
            return self.collectionView(cell, itemIdentifier: itemIdentifier, cellForRowAt: indexPath)
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerType = self.header[indexPath.section] else { return UICollectionReusableView() }
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerType.identifier, for: indexPath) as! BaseCollectionReusableView
                guard let item = self.viewModel?.headerData[indexPath.section] else { return UICollectionReusableView() }
                headerView.configure(item: item)
                headerView.controlEventDelegate = self
                return headerView
            } else {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ActivityIndicatorFooterView.identifier, for: indexPath)
                return footerView
            }
        }
        
        sinkWithViewModel()
    }
    
    
    open func collectionViewCompositionalSectionLayout(at sectionIndex: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: item.layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    open func collectionView(_ dequeueReusableCell: BaseCollectionViewCell, itemIdentifier: BaseCollectionData, cellForRowAt indexPath: IndexPath) -> BaseCollectionViewCell {
        dequeueReusableCell.configure(item: itemIdentifier)
        return dequeueReusableCell
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


extension BaseCollectionViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) { }
}

extension BaseCollectionViewController: BaseCollectionUIControlEventDelegate {
    
    public func handleComponentControlEvent(_ headerView: BaseCollectionReusableView, at indexPath: IndexPath, event: UIControl.Event) { }
    
    public func handleComponentControlEvent(_ cell: BaseCollectionViewCell, at indexPath: IndexPath, event: UIControl.Event) { }
}
