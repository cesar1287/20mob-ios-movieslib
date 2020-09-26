//
//  UiViewController+Context.swift
//  MoviesLib
//
//  Created by Cesar Nascimento on 26/09/20.
//  Copyright © 2020 Cesar Nascimento. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
}
