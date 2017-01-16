//
//  PhotoFetchedResultsController.swift
//  FaceSnap
//
//  Created by James Estrada on 12/01/2017.
//  Copyright © 2017 James Estrada. All rights reserved.
//

import UIKit
import CoreData

class PhotoFetchedResultsController: NSFetchedResultsController, NSFetchedResultsControllerDelegate {
    
    private let collectionView: UICollectionView
    
    init(fetchRequest: NSFetchRequest, managedObjectContext: NSManagedObjectContext, collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.delegate = self
        executeFetch()
    }
    
    func executeFetch() {
        do {
            try performFetch()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func performFetch(withPredicate predicate: NSPredicate?) {
        //even though we declared our fetch request in the init method to not cache anything, we will flush the cache anyways
        NSFetchedResultsController.deleteCacheWithName(nil) //with nil it deletes all possible caches
        fetchRequest.predicate = predicate
        executeFetch()
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView.reloadData()
    }
    
}
