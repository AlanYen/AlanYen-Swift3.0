//
//  ViewController.swift
//  Swift-0012-Deinitialization
//
//  Created by Alan Yen on 2017/6/17.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // A deinitializer is called immediately before a class instance is deallocated. 
        // You write deinitializers with the deinit keyword, similar to how initializers are written with the init keyword. 
        // Deinitializers are only available on class types.
        
        title = "Deinitialization"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            howDeinitializationWorks()
        }
        else if indexPath.row == 1 {
            deinitializersInAction()
        }
    }
    
    func howDeinitializationWorks() {
        
        // Swift automatically deallocates your instances when they are no longer needed, to free up resources
        
        // Class definitions can have at most one deinitializer per class. 
        // The deinitializer does not take any parameters and is written without parentheses:
        /*
        deinit {
            // perform the deinitialization
        }
         */
        
        // Deinitializers are called automatically, 
        // just before instance deallocation takes place. 
        // You are not allowed to call a deinitializer yourself.
        
        // Because an instance is not deallocated until after its deinitializer is called, 
        // a deinitializer can access all properties of the instance it is called on and can modify its behavior 
        // based on those properties 
        // (such as looking up the name of a file that needs to be closed).
    }
    
    func deinitializersInAction() {
    
        class Bank {
            static var coinsInBank = 10_000
            static func distribute(coins numberOfCoinsRequested: Int) -> Int {
                let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
                coinsInBank -= numberOfCoinsToVend
                return numberOfCoinsToVend
            }
            static func receive(coins: Int) {
                coinsInBank += coins
            }
        }
        
        class Player {
            var coinsInPurse: Int
            init(coins: Int) {
                coinsInPurse = Bank.distribute(coins: coins)
            }
            func win(coins: Int) {
                coinsInPurse += Bank.distribute(coins: coins)
            }
            deinit {
                Bank.receive(coins: coinsInPurse)
            }
        }
        
        var playerOne: Player? = Player(coins: 100)
        print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
        // Prints "A new player has joined the game with 100 coins"
        print("There are now \(Bank.coinsInBank) coins left in the bank")
        // Prints "There are now 9900 coins left in the bank"
        
        playerOne!.win(coins: 2_000)
        print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
        // Prints "PlayerOne won 2000 coins & now has 2100 coins"
        print("The bank now only has \(Bank.coinsInBank) coins left")
        // Prints "The bank now only has 7900 coins left"
        
        playerOne = nil
        print("PlayerOne has left the game")
        // Prints "PlayerOne has left the game"
        print("The bank now has \(Bank.coinsInBank) coins")
        // Prints "The bank now has 10000 coins"
    }
}
