# CollectionView-Restaurant

My code here is released free of copyrights. You may download, modify, distribute, and use them royalty free for anything you
like, even in commercial applications. Attribution is not required.

Images in code are taken from https://pixabay.com, which is also 100% free.

On this project UICollectionView usage is at work in Swift3:

Main classes:
------------

* ViewController class - main VC. shows how we connect collection to its delegate, how to do a register for the cell, how to create one
  when collection requires it (cellForItemAtIndex), how to repsond to selection and how to pass the data to next VC via Segue

* data.json - shows the content for the restaurant (dishes names, etc.) - it is a good practice to seperate your content data
  from the implementation of the collection, as you might wanna change it without concering coding., e.g. change name or price of 
  a dish.

* DataSourceManager - keeps all content data + parses its json
* DishCollectionViewCell - Custom cell, holds the image, title, price and checkmark image that sustains change on selection/deselection

Whenever I stated in remarks :"#TechNote", it's sn issue worth reading for better understanding.

Enjoy:)
