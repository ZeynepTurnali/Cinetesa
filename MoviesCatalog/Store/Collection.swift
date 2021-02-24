//
//  Collection.swift
//  MoviesCatalog

import Foundation


struct Collection {
    static var firstSection : [Result]? = []
    static var secondSection : [Result]? = []
    static var thirdSection: [Result]? = []
    
    static var bridge: [Result]? = []
    
    static var chosenSection = 0
    static var chosenMember = 0
    
    static var scrollFirst = 1
    static var scrollSecond = 1
    static var scrollThird = 1
}
