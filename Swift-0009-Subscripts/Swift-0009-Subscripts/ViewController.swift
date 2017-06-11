//
//  ViewController.swift
//  Swift-0009-Subscripts
//
//  Created by Alan Yen on 2017/6/11.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Classes, structures, and enumerations can define subscripts, 
        // which are shortcuts for accessing the member elements of a collection, list, or sequence. 
        // You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval. 
        // For example, you access elements in an Array instance as someArray[index] and elements in a Dictionary instance as someDictionary[key].
        
        title = "Subscripts"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            subscriptSyntax()
        }
        else if indexPath.row == 1 {
            subscriptUsage()
        }
        else if indexPath.row == 2 {
            subscriptOptions()
        }
    }
    
    func subscriptSyntax() {
        
        // read-write
        /*
        subscript(index: Int) -> Int {
            get {
                // return an appropriate subscript value here
            }
            set(newValue) {
                // perform a suitable setting action here
            }
        }
         */
        
        // read-only
        /*
        subscript(index: Int) -> Int {
            // return an appropriate subscript value here
        }
         */
        
        struct TimesTable {
            let multiplier: Int
            subscript(index: Int) -> Int {
                return multiplier * index
            }
        }
        let threeTimesTable = TimesTable(multiplier: 3)
        print("six times three is \(threeTimesTable[6])")
        // Prints "six times three is 18"
    }
    
    func subscriptUsage() {
        
        // Swift’s Dictionary type implements a subscript to set and retrieve the values stored in a Dictionary instance. 
        // You can set a value in a dictionary by providing a key of the dictionary’s key type within subscript brackets, 
        // and assigning a value of the dictionary’s value type to the subscript:
        
        var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        numberOfLegs["bird"] = 2
        print(numberOfLegs)
        
        // The example above defines a variable called numberOfLegs and initializes it with a dictionary literal containing three key-value pairs. 
        // The type of the numberOfLegs dictionary is inferred to be [String: Int]. 
        // After creating the dictionary, this example uses subscript assignment to add a String key of "bird" and an Int value of 2 to the dictionary.
    }
    
    func subscriptOptions() {
    
        // Subscripts can take any number of input parameters, 
        // and these input parameters can be of any type. 
        // Subscripts can also return any type. 
        // Subscripts can use variadic parameters, 
        // but they can’t use in-out parameters or 
        // provide default parameter values.
        
        // While it is most common for a subscript to take a single parameter,
        // you can also define a subscript with multiple parameters if it is appropriate for your type.
        
        struct Matrix {
            let rows: Int, columns: Int
            var grid: [Double]
            init(rows: Int, columns: Int) {
                self.rows = rows
                self.columns = columns
                grid = Array(repeating: 0.0, count: rows * columns)
            }
            func indexIsValid(row: Int, column: Int) -> Bool {
                return row >= 0 && row < rows && column >= 0 && column < columns
            }
            subscript(row: Int, column: Int) -> Double {
                get {
                    assert(indexIsValid(row: row, column: column), "Index out of range")
                    return grid[(row * columns) + column]
                }
                set {
                    assert(indexIsValid(row: row, column: column), "Index out of range")
                    grid[(row * columns) + column] = newValue
                }
            }
        }
        
        var matrix = Matrix(rows: 2, columns: 2)
        matrix[0, 1] = 1.5
        matrix[1, 0] = 3.2
        
        print(matrix[0, 1])
        print(matrix[1, 0])
        
        // let someValue = matrix[2, 2]
        // print(someValue)
        // this triggers an assert, because [2, 2] is outside of the matrix bounds
    }
}
