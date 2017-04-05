//
//
//  DishCollectionViewCell
//
//  Created by Ethan Halprin on 02/04/2017.
//  Copyright © 2017 Ethan Halprin. Free License.
//

import UIKit

//
// #TechNote : This class name must be set as the id for the cell
// also in the Interface Builder.
//
// -> On storyboard, select the cell of the collection view and in
// the identity inspector choose the Custom Class `DishCollectionViewCell`
//
class DishCollectionViewCell : UICollectionViewCell
{
    var cellID : String = ""
    
    @IBOutlet var imageView       : UIImageView!
    @IBOutlet var title           : UILabel!
    @IBOutlet var price           : UILabel!
    @IBOutlet var descriptor      : UILabel!
    
    @IBOutlet var checkImageView: UIImageView!
}
