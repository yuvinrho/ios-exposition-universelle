//
//  Expo1900 - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private weak var mainStackView: UIStackView!
    private let jsonDecoder = JSONDecoder()
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter
    }()
    private var exposition: Exposition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exposition = decodeExposition("exposition_universelle_1900")
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func decodeExposition(_ file: String) -> Exposition? {
        guard let expositionAsset: NSDataAsset = NSDataAsset(name: file) else { return nil }
        let exposition = try? jsonDecoder.decode(Exposition.self, from: expositionAsset.data)
        
        return exposition
    }
    
    private func goToKoreanItemsVC() {
        self.navigationController?.isNavigationBarHidden = false
        let storyboard = UIStoryboard(name: "KoreanItems", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "KoreanItemsViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func touchUpkoreanItemsViewButton() {
        goToKoreanItemsVC()
    }
    
    private func makeLabel(text: String?, font: UIFont, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.numberOfLines = numberOfLines
        
        return label
    }
    
    private func configureView() {
        let koreanTitleText = exposition?.koreanTitle
        let koreanTitleLabel: UILabel = makeLabel(text: koreanTitleText,
                                                  font: UIFont.preferredFont(forTextStyle: .title1))
        
        mainStackView.addArrangedSubview(koreanTitleLabel)
        
        let englishTitleText = exposition?.englishTitle
        let englishTitleLabel: UILabel = makeLabel(text: englishTitleText,
                                                   font: .preferredFont(forTextStyle: .title1))
        
        mainStackView.addArrangedSubview(englishTitleLabel)
        
        let posterImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "poster")
            
            return imageView
        }()
        
        mainStackView.addArrangedSubview(posterImageView)
        
        let visitorLabelText = "방문객 : \(numberFormatter.string(for: exposition?.visitors) ?? "")"
        let visitorsLabel: UILabel = makeLabel(text: visitorLabelText,
                                               font: UIFont.preferredFont(forTextStyle: .title3))
        
        mainStackView.addArrangedSubview(visitorsLabel)
        
        let locationLabelText = "개최지 : \(exposition?.location ?? "")"
        let locationLabel: UILabel = makeLabel(text: locationLabelText,
                                               font: UIFont.preferredFont(forTextStyle: .title3))
        
        mainStackView.addArrangedSubview(locationLabel)
        
        let durationLabelText = "개최 기간 : \(exposition?.duration ?? "")"
        let durationLabel: UILabel = makeLabel(text: durationLabelText,
                                               font: UIFont.preferredFont(forTextStyle: .title3))
        
        mainStackView.addArrangedSubview(durationLabel)
        
        let descriptionLabelText = exposition?.description
        let descriptionLabel: UILabel = makeLabel(text: descriptionLabelText,
                                                  font: UIFont.preferredFont(forTextStyle: .body),
                                                  numberOfLines: 0)
        
        mainStackView.addArrangedSubview(descriptionLabel)
        
        let koreanItemsViewButton: UIButton = {
            let button = UIButton()
            button.setTitle("🇰🇷 한국의 출품작 보러가기 🇰🇷", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.addTarget(self, action: #selector(touchUpkoreanItemsViewButton), for: .touchUpInside)
            
            return button
        }()
        
        mainStackView.addArrangedSubview(koreanItemsViewButton)
    }
}
