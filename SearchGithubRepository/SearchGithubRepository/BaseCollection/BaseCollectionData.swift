//
//  BaseCollectionData.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/08.
//

import Foundation
import UIKit.UIImage

open class BaseCollectionData: Hashable {
    
    public static func == (lhs: BaseCollectionData, rhs: BaseCollectionData) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: UUID = UUID()
    
    open var title: String
    
    open var subtitle: String?
    
    open var image: UIImage?
    
    init(title: String, subtitle: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
