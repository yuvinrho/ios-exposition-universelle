//
//  ItemViewController.swift
//  Expo1900
//
//  Created by 노유빈 on 2022/10/19.
//

import UIKit

final class ItemInfoViewController: UIViewController {
    @IBOutlet private weak var stackView: UIStackView!
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureStackView()
    }
    
    private func configureNavigation() {
        self.navigationItem.title = item?.name
    }
    
    private func configureStackView() {
        let itemImageView = UIImageView(image: UIImage(named: item?.imageName ?? "flag"))
        let itemDescriptionLabel: UILabel = {
            let label = UILabel()
            label.text = item?.desc
            label.numberOfLines = 0
            label.font = UIFont.preferredFont(forTextStyle: .body)
            
            return label
        }()
        
        stackView.addArrangedSubview(itemImageView)
        stackView.addArrangedSubview(itemDescriptionLabel)
    }
}
