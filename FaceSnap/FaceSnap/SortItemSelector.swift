//
//  SortItemSelector.swift
//  FaceSnap
//
//  Created by James Estrada on 13/01/2017.
//  Copyright © 2017 James Estrada. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SortItemSelector<SortType: NSManagedObject>: NSObject, UITableViewDelegate {
    
    private let sortItems: [SortType]
    var checkedItems: Set<SortType> = []
    
    init(sortItems: [SortType]) {
        self.sortItems = sortItems
        super.init()
    }
    
    // MARK: - UITableViewDelegate
    
    //add checkmark to the selected item
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0: //if it's on the all Tags(first section) it will uncheck all tags that are on the next section
            guard let cell = tableView.cellForRowAtIndexPath(indexPath) else { return }
            
            if cell.accessoryType == .None {
                cell.accessoryType = .Checkmark
                
                let nextSection = indexPath.section.advancedBy(1)
                
                let numberOfRowsInSubsequentSection = tableView.numberOfRowsInSection(nextSection)
                
                for row in 0..<numberOfRowsInSubsequentSection {
                    let indexPath = NSIndexPath(forRow: row, inSection: nextSection)
                    
                    let cell = tableView.cellForRowAtIndexPath(indexPath)
                    cell?.accessoryType = .None
                    
                    checkedItems = []
                    
                }
            }
        case 1: //unchecks the first section of all tags, add a checkmark to the highlighted cell and add that hilghlighted cell to the checked items list
            let allItemsIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            let allItemsCell = tableView.cellForRowAtIndexPath(allItemsIndexPath)
            allItemsCell?.accessoryType = .None
            
            guard let cell = tableView.cellForRowAtIndexPath(indexPath) else { return }
            let item = sortItems[indexPath.row]
            
            if cell.accessoryType == .None {
                cell.accessoryType = .Checkmark
                checkedItems.insert(item)
            } else if cell.accessoryType == .Checkmark {
                cell.accessoryType = .None
                checkedItems.remove(item)
            }
        default:
            break
        }
        
        print(checkedItems.description)
    }
}



















