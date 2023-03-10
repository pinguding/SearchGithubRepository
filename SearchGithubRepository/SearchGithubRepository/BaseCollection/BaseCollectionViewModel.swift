//
//  BaseCollectionViewModel.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/08.
//

import Foundation
import Combine

public protocol BaseCollectionViewModel: AnyObject {
    
    var collectionViewDataSource: [Int: [BaseCollectionData]] { get }
    
    var updateDataSourcePublisher: PassthroughSubject<[Int: [BaseCollectionData]], Never> { get }
    
    var headerData: [BaseCollectionData] { get }
    
    func applySnapshot()
    
    func requestNextPage()
}

public extension BaseCollectionViewModel {
    
    func applySnapshot() {
        updateDataSourcePublisher.send(collectionViewDataSource)
    }
    
    func requestNextPage() { }
}
