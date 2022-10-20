//  Created by rhovin on 2022/10/19.

import UIKit

final class ItemInfoViewController: UIViewController {
    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private weak var itemDescriptionLabel: UILabel!
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
    
    private func configureNavigation() {
        self.navigationItem.title = item?.name
    }
    
    private func configureView() {
        itemImage.image = UIImage(named: item?.imageName ?? "")
        itemImage.contentMode = .scaleAspectFit
        itemImage.clipsToBounds = true
        itemDescriptionLabel.text = item?.desc
    }
}
