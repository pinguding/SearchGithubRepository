//
//  HomeHeaderView.swift
//  SearchGithubRepository
//
//  Created by 박종우 on 2023/03/11.
//

import UIKit

final class HomeHeaderView: UICollectionReusableView, BaseCollectionReusableView {
    var indexPath: IndexPath?
    
    var controlEventDelegate: BaseCollectionUIControlEventDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clearButton.setTitle("기록 지우기", for: .normal)
    }
    
    func configure(item: BaseCollectionData, indexPath: IndexPath) {
        self.indexPath = indexPath
        titleLabel.text = item.title
    }
    
    @IBAction func clearButtonAction(_ sender: Any) {
        guard let indexPath = indexPath else { return }
        controlEventDelegate?.handleComponentControlEvent(self, at: indexPath, event: .touchUpInside)
    }
}
