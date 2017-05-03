# CollectionView-Restaurant

Restaurant order with text, subtext, selection, images

 ![screenshot](/Simulatorscreen1.png)
 
My code here is released free of copyrights. You may download, modify, distribute, and use them royalty free for anything you
like, even in commercial applications. Attribution is not required.

Images in code are taken from https://pixabay.com, which is also 100% free.

On this project UICollectionView usage is at work in Swift3.
Mind that the content is segregated and found in resources and in json format.

Main classes:
------------

* ViewController class - Main VC. shows how we connect collection to its delegate, how to do 
  register for the cell and how to create one when collection requires it (cellForItemAtIndex).
  Also how to repsond to selection and how to pass the data to next VC via Segue

* data.json - Holds the content for the restaurant (dishes names, etc.) - it is a good practice to seperate your content data from the implementation of the collection, as you might wanna change it without concering coding., e.g. change name or price or name of a dish.

* DataSourceManager - keeps all content data + parses its json when app loads

* DishCollectionViewCell - Custom cell, keeps properties like dish image, title, price and checkmark image that sustains change on selection/deselection

Whenever I stated in remarks :"#TechNote", it's an issue worth reading, for a better understanding.

Screenshots added in project for general impression.

Enjoy:)
