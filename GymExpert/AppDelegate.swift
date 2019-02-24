//
//  AppDelegate.swift
//  GymExpert
//
//  Created by Admin on 10/17/18.
//  Copyright © 2018 Nikita Tkachenko. All rights reserved.
//

import UIKit
import CoreData
import SwiftyGif
import SwiftGifOrigin

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        preloadData()
        
        let vc = ExerciseTableViewController()
        vc.context = persistentContainer.viewContext
        
        
        IQKeyboardManager.shared.enable = true
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .lightRed
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //        let workoutsTableViewController = WorkoutTableViewController()
        //        //        dummyViewController.view.backgroundColor = .blue
        //        let navController = CustomNavigationController(rootViewController: ExerciseTableViewController)
        //        window?.rootViewController = navController
        guard
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last,
            let url = URL(string: "\(documentPath)") else { return true }
        print(url)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "GymExpert")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    private func preloadData() {
        let preloadedDataKey = "didPreloadData"
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            guard let exerciseUrlPath = Bundle.main.url(forResource: "dataExercise", withExtension: "plist") else { return }
            
            let context = persistentContainer.viewContext
            
            let exerciseArrayContents = NSArray(contentsOf: exerciseUrlPath)!
            
            for dictionary in exerciseArrayContents {
                let exerciseDictionary = dictionary as! NSDictionary
                let exercise = Exercise(context: context)
                
                let imageName = exerciseDictionary["image"] as? String
                let image = UIImage(named: imageName!)
                let imageData = image!.pngData()
                
                exercise.image = imageData as Data?
                exercise.name = exerciseDictionary["name"] as? String
                exercise.levelLabel = exerciseDictionary["levelLabel"] as? String
                exercise.groupLabel = exerciseDictionary["groupLabel"] as? String
                exercise.descriptLabel = exerciseDictionary["descriptLabel"] as? String
            }
            
            do {
                try context.save()
                userDefaults.set(true, forKey: preloadedDataKey)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}