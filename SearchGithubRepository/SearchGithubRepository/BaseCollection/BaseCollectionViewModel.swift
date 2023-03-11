//
//  BaseCollectionViewModel.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/08.
//

import Foundation
import Combine

public protocol BaseCollectionViewModel: NSObject {
    
    var collectionViewDataSource: [BaseCollectionData] { get }
    
    var updateDataSourcePublisher: PassthroughSubject<[BaseCollectionData], Never> { get }
    
    var headerData: BaseCollectionData? { get }
    
    func applySnapshot()
}

public extension BaseCollectionViewModel {
    
    func applySnapshot() {
        updateDataSourcePublisher.send(collectionViewDataSource)
    }
}
