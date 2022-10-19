//  Created by Rhovin, Aejong on 2022/10/19.

import XCTest
@testable import Expo1900

class DecodingTest: XCTestCase {
    
    func test_디코딩했을때_exposition_universelle_1900을잘받아오는지() throws {
        
        let decoder = JSONDecoder()
        
        guard let expoAsset: NSDataAsset = NSDataAsset(name: "exposition_universelle_1900") else { return }
        
        let exposition = try? decoder.decode(Exposition.self, from: expoAsset.data)
        XCTAssertNotNil(exposition)
    }
    
    func test_디코딩했을때_items_잘받아오는지() throws {
        
        let decoder = JSONDecoder()
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "items") else { return }
        
        let items = try? decoder.decode([Item].self, from: dataAsset.data)
        XCTAssertNotNil(items)
    }
}
