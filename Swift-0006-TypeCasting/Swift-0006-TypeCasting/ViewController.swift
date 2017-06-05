//
//  ViewController.swift
//  Swift-0006-TypeCasting
//
//  Created by Alan Yen on 2017/6/5.
//  Copyright © 2017年 Alan-App. All rights reserved.
//

import UIKit

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
// the type of "library" is inferred to be [MediaItem]
// The items stored in library are still Movie and Song instances behind the scenes. 
// However, if you iterate over the contents of this array, 
// the items you receive back are typed as MediaItem, 
// and not as Movie or Song. In order to work with them as their native type, 
// you need to check their type, or downcast them to a different type

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Type casting in Swift is implemented with the is and as operators. 
        // These two operators provide a simple and expressive way to 
        // check the type of a value or cast a value to a different type.
        
        title = "Type Casting"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            checkingType()
        }
        else if indexPath.row == 1 {
            downcasting()
        }
        else if indexPath.row == 2 {
            typeCastingForAnyAndAnyObject()
        }
        else if indexPath.row == 3 {
            optionalAsAny()
        }
    }
    
    func checkingType() {
        
        // Use the type check operator (is) to check whether an instance is of a certain subclass type. 
        // The type check operator returns true if the instance is of that subclass type and false if it is not.
        
        var movieCount = 0
        var songCount = 0
        
        // item is MediaItem always true
        for item in library {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            }
        }
        
        print("Media library contains \(movieCount) movies and \(songCount) songs")
        // Prints "Media library contains 2 movies and 3 songs"
    }
    
    func downcasting() {
        
        // Because downcasting can fail, the type cast operator comes in two different forms.
        // The conditional form, as?, returns an optional value of the type you are trying to downcast to. 
        // The forced form, as!, attempts the downcast and force-unwraps the result as a single compound action.
        
        // Use the conditional form of the type cast operator (as?) when you are not sure 
        // if the downcast will succeed. 
        // This form of the operator will always return an optional value, 
        // and the value will be nil if the downcast was not possible. 
        // This enables you to check for a successful downcast.
        
        // Use the forced form of the type cast operator (as!) only when you are sure that the downcast will always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
        
        for item in library {
            if let movie = item as? Movie {
                print("Movie: \(movie.name), dir. \(movie.director)")
            } else if let song = item as? Song {
                print("Song: \(song.name), by \(song.artist)")
            }
        }
        
        // Movie: Casablanca, dir. Michael Curtiz
        // Song: Blue Suede Shoes, by Elvis Presley
        // Movie: Citizen Kane, dir. Orson Welles
        // Song: The One And Only, by Chesney Hawkes
        // Song: Never Gonna Give You Up, by Rick Astley
    }
    
    func typeCastingForAnyAndAnyObject() {
    
        // Swift provides two special types for working with nonspecific types:
        // Any can represent an instance of any type at all, 
        // including function types.
        // AnyObject can represent an instance of any class type.

        var things = [Any]()
        
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({ (name: String) -> String in "Hello, \(name)" })
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called \(movie.name), dir. \(movie.director)")
            case let stringConverter as (String) -> String:
                print(stringConverter("Michael"))
            default:
                print("something else")
            }
        }
        
        // zero as an Int
        // zero as a Double
        // an integer value of 42
        // a positive double value of 3.14159
        // a string value of "hello"
        // an (x, y) point at 3.0, 5.0
        // a movie called Ghostbusters, dir. Ivan Reitman
        // Hello, Michael
    }
    
    func optionalAsAny() {
        
        // The Any type represents values of any type, including optional types. 
        // Swift gives you a warning if you use an optional value where a value of type Any is expected.
        // If you really do need to use an optional value as an Any value, 
        // you can use the as operator to explicitly cast the optional to Any, as shown below.
        
        var things = [Any]()
        
        let optionalNumber: Int? = 3
        things.append(optionalNumber)        // Warning
        things.append(optionalNumber as Any) // No warning
    }
}
