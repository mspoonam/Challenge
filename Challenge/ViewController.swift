//
//  ViewController.swift
//  Challenge
//
//  Created by Poonam Pandey on 25/01/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    private var button : UIButton?
    private var tableView : UITableView?
    
    // As per the spec the total number of tiles to be colored are 5
    // Let number of rows to be colored be 5
    let rows = 5
    
    var colors : Array<UIColor> = [UIColor.brown,UIColor.cyan,UIColor.darkGray]
    var dataSourceForTable : Array<UIColor> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        self.createDataSource()
        
        self.createView()
    }

    func createView(){
        self.button = UIButton()
        self.button?.backgroundColor = UIColor.blue
        self.button?.titleLabel?.textColor = UIColor.black
        self.button?.setTitle("Press Me!", for:UIControlState.normal)
        self.button?.addTarget(self, action: #selector(pressButton(_:)), for: UIControlEvents.touchUpInside)
        self.tableView = UITableView()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.button!)
        self.view.addSubview(self.tableView!)
        self.tableView?.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        let frame : CGRect = self.view.frame
        self.button?.frame = CGRect(x:0, y:0, width:100, height:100)
        self.tableView?.frame = CGRect(x:0, y:100, width:frame.width, height:frame.height - 100)
    }
    
    func createDataSource(){
        
        if dataSourceForTable.count>0 {dataSourceForTable.removeAll()}
        var counter = 0
        while (counter<rows){
            if (counter<colors.count){
                dataSourceForTable.append(colors[counter])
                if (dataSourceForTable.count==colors.count){
                    counter=0
                    continue
                }
            }
            if (dataSourceForTable.count==rows){
                break
            }
            counter+=1
        }
        
    }
    
    
    
    func shuffleColors (){
        // call the shuffle master code
        colors = colors.shuffled()
    }
    
    
    
    // MARK table view delegates
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Lets make the tiles
        let cell  = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        cell.backgroundColor = dataSourceForTable[indexPath.row]
        
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // this will refer to the number of tiles in the table
        // I need to make them look colorful
        return rows
    }
    
    
    @objc func pressButton(_ sender:Any){
        self.shuffleColors()
        // Lets call the sorter
        self.createDataSource()
        // Lets update the table
        self.tableView?.reloadData()
    }
    
    
    
}

extension Array {
    
    func shuffled() -> Array<Element> {
        var indexArray = Array<Int>(indices)
        var index = indexArray.endIndex
        
        let indexIterator = AnyIterator<Int> {
            guard let nextIndex = indexArray.index(index, offsetBy: -1, limitedBy: indexArray.startIndex)
                else { return nil }
            
            index = nextIndex
            let randomIndex = Int(arc4random_uniform(UInt32(index)))
            if randomIndex != index {
                indexArray.swapAt(randomIndex, index)
            }
            
            return indexArray[index]
        }
        
        return indexIterator.map { self[$0] }
    }
    
}

