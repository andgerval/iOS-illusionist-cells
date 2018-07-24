# iOS-illusionist-cells
An iOS PoC for displaying nested table cells.

Originally released on January 1st 12:00AM.

# Method
When approaching this problem the first thought that comes to mind is to dynamically nest a second table view within the selected cell and do some trickery with the cells height. My method is actually to use UITableViewController, UITableViewDataSource, and UITableViewDelegate as they are and do most of the heavy lifting with the datasource. This is turn gives the 'illusion' of nested table cells. Of course this is over simplified and there is some logic outside of the data source that makes this possible the best way to understand is to run the demo project and dissect the code yourself.

Feel free to contribute, take & modify, and or make suggestions! 😀

### Thorough documentation will be written after all of the festivities have ended! 🎊🎆
