//
//  BillViewController.swift
//  CollectionViewRestaurant
//
//  Created by Ethan Halprin on 02/04/2017.
//  Copyright © 2017 Ethan Halprin. Free License.
//

import UIKit

class BillViewController: UIViewController
{
    
    @IBOutlet var nameStackView: UIStackView!
    
    internal var names:  [String] = [String]()
    internal var prices: [String] = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        guard names.count > 0 && prices.count > 0 && names.count == prices.count else
        {
            return
        }
        
        let count = names.count // can be also prices.count
        
        for i in 0..<count
        {
            let label = UILabel()
            label.text = "\(names[i])" + "......." + "\(prices[i])"
            nameStackView.addArrangedSubview(label)
        }
        
        var sum = 0
        for price in prices
        {
            // remove the '$'
            let p = price.substring(to: price.index(before: price.endIndex))
            
            let intPrice = (p as NSString).integerValue
            
            sum += intPrice
        }
        
        let line = UILabel()
        line.text = "______________________________"
        nameStackView.addArrangedSubview(line)

        let total = UILabel()
        total.text = "TOTAL......." + String(sum) + "$"
        nameStackView.addArrangedSubview(total)
    }
}
