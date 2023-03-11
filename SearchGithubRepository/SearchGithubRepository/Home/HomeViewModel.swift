//
//  HomeViewModel.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/11.
//

import Foundation
import Combine

final class HomeViewModel: BaseCollectionViewModel {
    
    var collectionViewDataSource: [Int : [BaseCollectionData]] = [:]
    
    var updateDataSourcePublisher: PassthroughSubject<[Int : [BaseCollectionData]], Never> = .init()
    
    var headerData: [BaseCollectionData] = []
    
    
}
