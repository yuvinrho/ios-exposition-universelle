//  Created by rhovin on 2022/10/19.

import UIKit

final class KoreanItemsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let cellIdentifier = "itemCell"
    private let jsonDecoder = JSONDecoder()
    private var items: [Item]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = decodeItems("items")
        confiureTableView()
    }
    
    private func decodeItems(_ file: String) -> [Item]? {
        guard let dataAsset: NSDataAsset = NSDataAsset(name: file) else { return nil }
        let items = try? jsonDecoder.decode([Item].self, from: dataAsset.data)
        
        return items
    }
    
    private func confiureTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension KoreanItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                                  for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: items?[indexPath.row].imageName ?? "")
        cell.textLabel?.text = items?[indexPath.row].name
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        cell.detailTextLabel?.text = items?[indexPath.row].shortDesc
        cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        
        return cell
    }
}

extension KoreanItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ItemInfo", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemInfoViewController") as! ItemInfoViewController
        vc.item = items?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
