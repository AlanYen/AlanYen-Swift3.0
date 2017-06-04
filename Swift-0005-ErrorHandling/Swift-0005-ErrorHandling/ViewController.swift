//
//  ViewController.swift
//  Swift-0005-ErrorHandling
//
//  Created by Alan Yen on 2017/6/4.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        
        // uses guard statements to exit the method early and throw appropriate errors
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

class ViewController: UITableViewController {
    
    let favoriteSnacks = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels",
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Error Handling"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            try? representingAndThrowingErrors()
        }
        else if indexPath.row == 1 {
            try? propagatingErrorsUsingThrowingFunctions()
        }
        else if indexPath.row == 2 {
            handlingErrorsUsingDoCatch()
        }
        else if indexPath.row == 3 {
            convertingErrorsToOptionalValues()
        }
        else if indexPath.row == 4 {
            disablingErrorPropagation()
        }
        else if indexPath.row == 5 {
            specifyingCleanupActions()
        }
    }
    
    func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
    }
    
    func representingAndThrowingErrors() throws {
        
        // In Swift, errors are represented by values of types that conform to the Error protocol.
        
        throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
    }
    
    func propagatingErrorsUsingThrowingFunctions() throws {
        
        // To indicate that a function, method, or initializer
        // can throw an error, you write the throws keyword 
        // in the function’s declaration after its parameters. 
        
        // A function marked with throws is called a throwing function. 
        
        // If the function specifies a return type, 
        // you write the throws keyword before the return arrow (->).
        
        // func canThrowErrors() throws -> String
        // func cannotThrowErrors() -> String
        
        
        // Because the vend(itemNamed:) method propagates any errors it throws,
        // any code that calls this method must either handle the errors—using a
        // do-catch statement, try?, or try!—or continue to propagate them
        
        let favoriteSnacks = [
            "Alice": "Chips",
            "Bob": "Licorice",
            "Eve": "Pretzels",
            ]
        
        func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
            let snackName = favoriteSnacks[person] ?? "Candy Bar"
            try vendingMachine.vend(itemNamed: snackName)
        }
        
        let vendingMachine = VendingMachine()
        try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    }
    
    func handlingErrorsUsingDoCatch() {
    
        // You use a do-catch statement to handle errors by running a block of code.
        // If an error is thrown by the code in the do clause, 
        // it is matched against the catch clauses to determine 
        // which one of them can handle the error.
        
        let vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        
        do {
            try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
        } catch VendingMachineError.invalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock {
            print("Out of Stock.")
        } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        } catch {
            print("ELSE")
        }
        // Prints "Insufficient funds. Please insert an additional 2 coins."
    }
    
    func convertingErrorsToOptionalValues() {
    
        // You use try? to handle an error by converting it to an optional value. 
        // If an error is thrown while evaluating the try? expression, 
        // the value of the expression is nil. 
        // For example, in the following code x and y have the same value and behavior:
        
        
        func someThrowingFunction() throws -> Int {
            // ...
            return 1
        }
        
        let x = try? someThrowingFunction()
        print(x ?? -1000)
        
        let y: Int?
        do {
            y = try someThrowingFunction()
        } catch {
            y = nil
        }
        print(y ?? -1000)
        
        // If someThrowingFunction() throws an error, the value of x and y is nil. 
        // Otherwise, the value of x and y is the value that the function returned. 
        // Note that x and y are an optional of whatever type someThrowingFunction() 
        // returns. Here the function returns an integer, so x and y are optional integers.
        
        // Using try? lets you write concise error handling code when you want to 
        // handle all errors in the same way. 
        // For example, the following code uses several approaches to fetch data, 
        // or returns nil if all of the approaches fail.
        
        /*
        func fetchData() -> Data? {
            if let data = try? fetchDataFromDisk() { return data }
            if let data = try? fetchDataFromServer() { return data }
            return nil
        }
         */
    }
    
    func disablingErrorPropagation() {
        
        // Sometimes you know a throwing function or method won’t, in fact, throw an error at runtime
        // let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
    }
    
    func specifyingCleanupActions() {
        
        // You use a defer statement to execute a set of statements just 
        // before code execution leaves the current block of code
        
        // whether it leaves because an error was thrown or because of
        // a statement such as return or break
        
        /*
        func processFile(filename: String) throws {
            if exists(filename) {
                let file = open(filename)
                defer {
                    close(file)
                }
                while let line = try file.readline() {
                    // Work with the file.
                }
                // close(file) is called here, at the end of the scope.
            }
        }
         */
    }
}
