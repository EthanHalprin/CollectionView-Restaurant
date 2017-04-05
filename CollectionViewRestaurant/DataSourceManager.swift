//
//  DataSourceManager.swift
//  CollectionViewRestaurant
//
//  Created by Ethan Halprin on 02/04/2017.
//  Copyright © 2017 Ethan Halprin. Free License.
//

import Foundation

class DataSourceManager
{
    var name = String()
    var address = String()

    var main = [MenuItem]()
    var salads = [MenuItem]()
    var drinks = [MenuItem]()
    
    // #TechNote : in the course of the parse process here, we must state the
    // exact type expected. e.g.:
    //
    // let menu : [String : [[String : String]]] = object["menu"] as! [String : [[String : String]]]
    //
    // This is because Swift is not familiar with our json specific structure
    //
    // (If you find somewhat confusing, you can try SwiftyJson for an easier syntax)
    //
    internal func parseJSON()
    {
        do
        {
            if let file = Bundle.main.url(forResource: "data", withExtension: "json")
            {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let object = json as? [String: Any]
                {
                    //
                    // Extract the name, type and address
                    //
                    self.name = object["name"] as! String
                    self.address = object["address"] as! String
                    //
                    // Extract menu (complex: dictionary inside array inside dictionary
                    //
                    let menu : [String : [[String : String]]] = object["menu"] as! [String : [[String : String]]]
                    //
                    // Extract mains from menu
                    //
                    let main = menu["main"] //type here: [[String : String]]
                    for m in main!
                    {
                        // each `m` is a [String : String]
                        let item = deserialize(item: m)
                        
                        self.main.append(item)
                    }
                    //
                    // Extract salads from menu
                    //
                    let salads = menu["salads"] //type here: [[String : String]]
                    for salad in salads!
                    {
                        // each `salad` is a [String : String]
                        let item = deserialize(item: salad)
                        
                        self.salads.append(item)
                    }
                    //
                    // Extract drinks from menu
                    //
                    let drinks = menu["drinks"] //type here: [[String : String]]
                    for drink in drinks!
                    {
                        // each `drink` is a [String : String]
                        let item = deserialize(item: drink)
                        
                        self.drinks.append(item)
                    }
                }
                else if let object = json as? [Any]
                {
                    // json is an array
                    print(object)
                }
                else
                {
                    print("JSON is invalid")
                }
            }
            else
            {
                print("no file")
            }
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    private func deserialize(item : [String : String]) -> MenuItem
    {
        let newMenuItem = MenuItem()
        
        newMenuItem.itemID     = item["id"]!
        newMenuItem.name       = item["title"]!
        newMenuItem.price      = item["price"]!
        newMenuItem.picture    = item["image"]!
        newMenuItem.descriptor = item["description"]!
        
        return newMenuItem
    }
}

