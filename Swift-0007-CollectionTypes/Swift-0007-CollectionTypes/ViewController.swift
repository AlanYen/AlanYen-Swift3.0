//
//  ViewController.swift
//  Swift-0007-CollectionTypes
//
//  Created by Alan Yen on 2017/6/5.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Swift provides three primary collection types, 
        // known as arrays, sets, and dictionaries, 
        // for storing collections of values. 
        // Arrays are ordered collections of values. 
        // Sets are unordered collections of unique values. 
        // Dictionaries are unordered collections of key-value associations.

        title = "Collection Types"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Mark: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            arrayTypeShorthandSyntax()
        }
        else if indexPath.row == 1 {
            creatingAnArrayWithADefaultValue()
        }
        else if indexPath.row == 2 {
            accessingAndModifyingAnArray()
        }
        else if indexPath.row == 3 {
            dictionaryTypeShorthandSyntax()
        }
        else if indexPath.row == 4 {
            accessingAndModifyingADictionary()
        }
        else if indexPath.row == 5 {
            accessingAndModifyingASet()
        }
        else if indexPath.row == 6 {
            fundamentalSetOperations()
        }
        else if indexPath.row == 7 {
            setMembershipAndEquality()
        }
    }
    
    func arrayTypeShorthandSyntax() {
        
        // The type of a Swift array is written in full as Array<Element>,
        // where Element is the type of values the array is allowed to store. 
        // You can also write the type of an array in shorthand form as [Element].
        
        var someInts: Array<Int> = []
        someInts.append(1)
        print(someInts)
        
        // the shorthand form is preferred
        var shortSomeInts = [Int]()
        shortSomeInts.append(2)
        print(shortSomeInts)
    }
    
    func creatingAnArrayWithADefaultValue() {
        
        let threeDoubles = Array(repeating: 0.0, count: 3)
        print(threeDoubles)
        
        // threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]

        let fourDoubles = [0.0, 0.0, 0.0, 0.0]
        print(fourDoubles)
        
        // Creating an Array by Adding Two Arrays Together
        
        let sevenDoubled = threeDoubles + fourDoubles
        print(sevenDoubled)
    }
    
    func accessingAndModifyingAnArray() {
    
        var shoppingList = ["Eggs", "Milk"]
        
        print("The shopping list contains \(shoppingList.count) items.")
        // Prints "The shopping list contains 2 items."
        
        // isEmpty
        if shoppingList.isEmpty {
            print("The shopping list is empty.")
        } else {
            print("The shopping list is not empty.")
        }
        // Prints "The shopping list is not empty."
        
        shoppingList.append("Flour")
        print(shoppingList)
        // shoppingList now contains 3 items, and someone is making pancakes
        
        shoppingList += ["Baking Powder"]
        print(shoppingList)
        // shoppingList now contains 4 items
        
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
        print(shoppingList)
        // shoppingList now contains 7 items
        
        // subscript syntax
        shoppingList[0] = "Six eggs"
        print(shoppingList)
        // the first item in the list is now equal to "Six eggs" rather than "Eggs"
        
        shoppingList[4...6] = ["Bananas", "Apples"]
        print(shoppingList)
        // shoppingList now contains 6 items
        
        shoppingList.insert("Maple Syrup", at: 0)
        print(shoppingList)
        // shoppingList now contains 7 items
        // "Maple Syrup" is now the first item in the list
        
        let mapleSyrup = shoppingList.remove(at: 0)
        // Returns: The element at the specified index.
        print(shoppingList)
        print(mapleSyrup)
        // the item that was at index 0 has just been removed
        // shoppingList now contains 6 items, and no Maple Syrup
        // the mapleSyrup constant is now equal to the removed "Maple Syrup" string
        
        let apples = shoppingList.removeLast()
        print(shoppingList)
        print(apples)
        // the last item in the array has just been removed
        // shoppingList now contains 5 items, and no apples
        // the apples constant is now equal to the removed "Apples" string
        
        for item in shoppingList {
            print(item)
        }
        // Six eggs
        // Milk
        // Flour
        // Baking Powder
        // Bananas
        
        for (index, value) in shoppingList.enumerated() {
            print("Item \(index + 1): \(value)")
        }
        // Item 1: Six eggs
        // Item 2: Milk
        // Item 3: Flour
        // Item 4: Baking Powder
        // Item 5: Bananas
    }
    
    func dictionaryTypeShorthandSyntax() {
        
        // The type of a Swift dictionary is written in full as Dictionary<Key, Value>, 
        // where Key is the type of value that can be used as a dictionary key, 
        // and Value is the type of value that the dictionary stores for those keys.
        
        // A dictionary Key type must conform to the Hashable protocol, like a set’s value type.
        
        // You can also write the type of a dictionary in shorthand form as [Key: Value]. 
        // Although the two forms are functionally identical, 
        // the shorthand form is preferred and is used throughout this guide when referring
        // to the type of a dictionary.

        var namesOfIntegers: Dictionary<Int, String> = [:]
        namesOfIntegers[1] = "1"
        print(namesOfIntegers)
        
        // the shorthand form is preferred
        var shortNamesOfIntegers = [Int: String]()
        shortNamesOfIntegers[1] = "1"
        print(shortNamesOfIntegers)
    }
    
    func accessingAndModifyingADictionary() {
        
        var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        print("The airports dictionary contains \(airports.count) items.")
        // Prints "The airports dictionary contains 2 items."
        
        // isEmpty
        if airports.isEmpty {
            print("The airports dictionary is empty.")
        } else {
            print("The airports dictionary is not empty.")
        }
        // Prints "The airports dictionary is not empty."
        
        // As an alternative to subscripting, use a dictionary’s updateValue(_:forKey:) method
        // to set or update the value for a particular key. 
        // Like the subscript examples above, the updateValue(_:forKey:) method sets a value 
        // for a key if none exists, or updates the value if that key already exists. 
        // Unlike a subscript, however, the updateValue(_:forKey:) method returns the old value
        // after performing an update. This enables you to check whether or not an update took place.
        
        // The updateValue(_:forKey:) method returns an optional value of the dictionary’s value type.
        // For a dictionary that stores String values, 
        // for example, the method returns a value of type String?, or “optional String”. 
        // This optional value contains the old value for that key if one existed before the update, 
        // or nil if no value existed:
            
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        // Prints "The old value for DUB was Dublin."
        
        // You can also use subscript syntax to retrieve a value from the dictionary for a particular key. 
        // Because it is possible to request a key for which no value exists, 
        // a dictionary’s subscript returns an optional value of the dictionary’s value type. 
        // If the dictionary contains a value for the requested key, 
        // the subscript returns an optional value containing the existing value for that key. 
        // Otherwise, the subscript returns nil:
        
        if let airportName = airports["DUB"] {
            print("The name of the airport is \(airportName).")
        } else {
            print("That airport is not in the airports dictionary.")
        }
        // Prints "The name of the airport is Dublin Airport."
        
        // you can use subscript syntax to remove a key-value pair from a dictionary 
        // by assigning a value of nil for that key:
        
        airports["APL"] = "Apple International"
        // "Apple International" is not the real airport for APL, so delete it
        airports["APL"] = nil
        // APL has now been removed from the dictionary
        
        // Alternatively, remove a key-value pair from a dictionary with the removeValue(forKey:) method.
        // This method removes the key-value pair if it exists and returns the removed value, 
        // or returns nil if no value existed:
            
        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removedValue).")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
        // Prints "The removed airport's name is Dublin Airport."
        
        // You can iterate over the key-value pairs in a dictionary with a for-in loop. 
        // Each item in the dictionary is returned as a (key, value) tuple, 
        // and you can decompose the tuple’s members into temporary constants or variables 
        // as part of the iteration:
            
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        // YYZ: Toronto Pearson
        // LHR: London Heathrow
        
        // You can also retrieve an iterable collection of a dictionary’s keys 
        // or values by accessing its keys and values properties:
            
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        // Airport code: YYZ
        // Airport code: LHR
        
        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }
        // Airport name: Toronto Pearson
        // Airport name: London Heathrow
        
        // If you need to use a dictionary’s keys or values with an API that takes an Array instance, 
        // initialize a new array with the keys or values property:
        
        let airportCodes = [String](airports.keys)
        print(airportCodes)
        // airportCodes is ["YYZ", "LHR"]
        
        let airportNames = [String](airports.values)
        print(airportNames)
        // airportNames is ["Toronto Pearson", "London Heathrow"]
    }
    
    func accessingAndModifyingASet() {
    
        var letters = Set<Character>()
        print("letters is of type Set<Character> with \(letters.count) items.")
        // Prints "letters is of type Set<Character> with 0 items."
        
        letters.insert("a")
        // letters now contains 1 value of type Character
        letters = []
        // letters is now an empty set, but is still of type Set<Character>
        
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        // favoriteGenres has been initialized with three initial items
        
        print("I have \(favoriteGenres.count) favorite music genres.")
        // Prints "I have 3 favorite music genres."
        
        // isEmpty
        if favoriteGenres.isEmpty {
            print("As far as music goes, I'm not picky.")
        } else {
            print("I have particular music preferences.")
        }
        // Prints "I have particular music preferences."
        
        // You can add a new item into a set by calling the set’s insert(_:) method:
        
        favoriteGenres.insert("Jazz")
        // favoriteGenres now contains 4 items
        
        // You can remove an item from a set by calling the set’s remove(_:) method, 
        // which removes the item if it’s a member of the set, and returns the removed value, 
        // or returns nil if the set did not contain it. 
        // Alternatively, all items in a set can be removed with its removeAll() method.
        
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }
        // Prints "Rock? I'm over it."
        
        if favoriteGenres.contains("Funk") {
            print("I get up on the good foot.")
        } else {
            print("It's too funky in here.")
        }
        // Prints "It's too funky in here."
        
        for genre in favoriteGenres {
            print("\(genre)")
        }
        // Jazz
        // Hip hop
        // Classical
        
        // Swift’s Set type does not have a defined ordering. 
        // To iterate over the values of a set in a specific order, 
        // use the sorted() method, which returns the set’s elements 
        // as an array sorted using the < operator.
        
        for genre in favoriteGenres.sorted() {
            print("\(genre)")
        }
        // Classical
        // Hip hop
        // Jazz
    }
    
    func fundamentalSetOperations() {
    
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        
        print(oddDigits.union(evenDigits).sorted())
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        print(oddDigits.intersection(evenDigits).sorted())
        // []
        print(oddDigits.subtracting(singleDigitPrimeNumbers).sorted())
        // [1, 9]
        print(oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted())
        // [1, 2, 9]
    }
    
    func setMembershipAndEquality() {
        
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        
        print(houseAnimals.isSubset(of: farmAnimals))
        // true
        print(farmAnimals.isSuperset(of: houseAnimals))
        // true
        print(houseAnimals.isStrictSubset(of: farmAnimals))
        // true
        print(farmAnimals.isStrictSuperset(of: houseAnimals))
        // true
        print(farmAnimals.isDisjoint(with: cityAnimals))
        // true
    }
}
