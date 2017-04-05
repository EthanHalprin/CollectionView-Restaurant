//
//  ViewController.swift
//  CollectionViewRestaurant
//
//  Created by Ethan Halprin on 02/04/2017.
//  Copyright © 2017 Ethan Halprin. Free License.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    //
    // MARK: Properties
    //
    
    // outlet for the collection view on Interface Builder
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var restaurantTitleHeader: UILabel!
    @IBOutlet var restaurantAddress: UILabel!
    
    // #TechNote : Id for reuse (must be identical to the one in Interface Builder)
    let reuseIdentifier       = "ReuseCellIdentifier"
    let headerReuseIdentifier = "ReuseHeaderIdentifier"
    
    
    // #TechNote : This babe shall be responsible for handling all the 
    // data input for resaurant collection view, which reisdes in the 
    // json "data.json" on Resources
    let dataSrcManager = DataSourceManager()
    
    var selectedNames  = [String : String]()
    var selectedPrices = [String : String]()
    
    //
    // MARK: ViewDidLoad
    //
    override func viewDidLoad()
    {
        super.viewDidLoad()

        dataSrcManager.parseJSON()
        restaurantTitleHeader.text = dataSrcManager.name
        restaurantAddress.text = dataSrcManager.address

        // #TechNote : this 2 next lines are a must. They "tell" the table view from where
        // it can draw cells, headers and resond to selections.
        //
        // These can also be set on storyboard (on collectionView's connections inspector)
        //
        collectionView.dataSource = self
        collectionView.delegate   = self
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
    }
    //
    // MARK: UICollectionViewDataSource
    //
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var numberOfItemsInSection : Int = 0
        
        switch section
        {
            case 0: numberOfItemsInSection = dataSrcManager.main.count
            case 1: numberOfItemsInSection = dataSrcManager.salads.count
            case 2: numberOfItemsInSection = dataSrcManager.drinks.count
            
            default :break
        }
        
        return numberOfItemsInSection
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        // #TechNote : The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
        let cell : DishCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? DishCollectionViewCell
        
        guard let dishCell = cell else
        {
            // should never get here but just in case
            return UICollectionViewCell()
        }
        
        print("======cellForItemAtIndexPath: section \(indexPath.section) row \(indexPath.row)======")
        
        // #TechNote : Here we take the content from the Data Source Manager that parsed
        // the data from the json earlier (on viewDidLoad)
        // each new indexPath leads to a new record in data array of DataSourceManager
        
        var itemsArray : [MenuItem]? = nil
        switch indexPath.section
        {
            case 0: itemsArray = dataSrcManager.main
            case 1: itemsArray = dataSrcManager.salads
            case 2: itemsArray = dataSrcManager.drinks
            default : break
        }
        
        if let items = itemsArray
        {
            dishCell.cellID = items[indexPath.row].itemID
            dishCell.title.text = items[indexPath.row].name
            dishCell.price.text = items[indexPath.row].price
            dishCell.imageView.image = UIImage(named: items[indexPath.row].picture)
            dishCell.descriptor.text = items[indexPath.row].descriptor
        }
        
        // finally - convey selection on UI
        if dishCell.isSelected
        {
            dishCell.checkImageView.isHidden = false
        }
        else
        {
            dishCell.checkImageView.isHidden = true
        }
        
        return dishCell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        var header: DishHeaderView?
        
        if kind == UICollectionElementKindSectionHeader
        {
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as? DishHeaderView
            
            var text : String = ""
            switch indexPath.section
            {
                case 0: text = "MAIN"
                case 1: text = "SALADS"
                case 2: text = "DRINKS"
                default : break
            }

            header?.title.text = text
        }
        return header!
    }

    //
    // UICollectionViewDelegate
    //
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell : DishCollectionViewCell? = collectionView.cellForItem(at: indexPath) as? DishCollectionViewCell
        
        if let cell = cell
        {
            print("didSelectItemAt OK : section \(indexPath.section) row \(indexPath.row)")

            cell.checkImageView.isHidden = false
            
            selectedNames[cell.cellID] = cell.title.text!
            selectedPrices[cell.cellID] = cell.price.text!
        }
    }
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        let cell : DishCollectionViewCell? = collectionView.cellForItem(at: indexPath) as? DishCollectionViewCell
        
        if let cell = cell
        {
            print("didDeselectItemAt OK : section \(indexPath.section) row \(indexPath.row)")
            
            cell.checkImageView.isHidden = true
            
            selectedNames[cell.cellID] = nil
            selectedPrices[cell.cellID] = nil
        }
    }
    //
    // MARK: PrepareForSegue
    //
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dest = segue.destination as! BillViewController
        
        for (_,v) in selectedNames
        {
            dest.names.append(v)
        }
        for (_,v) in selectedPrices
        {
            dest.prices.append(v)
        }
        
        // #TechNote: why not use here `self.collectionView.indexPathsForSelectedItems`
        // instead of keeping the selected all the way?
        //
        // Mind Doc of UICollectionView of that self.collectionView.indexPathsForSelectedItems:
        //
        // Return Value
        // The cell object at the corresponding index path or nil if the cell is not visible or indexPath is out of range.
    }

}

