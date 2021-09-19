//
//  PlayData.swift
//  HWS Testing Project
//
//  Created by Anton Makeev on 19.09.2021.
//

import Foundation

class PlayData {
    
    var allWords = [String]()
    var wordCounts = NSCountedSet()
    private(set) var filteredWords = [String]()
    
    init() {
        if let path = Bundle.main.path(forResource: "plays", ofType: "txt") {
            if let plays = try? String(contentsOfFile: path) {
                allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
            }
        }
        allWords = allWords.filter { $0 != "" }
        wordCounts = NSCountedSet(array: allWords)
        let sorted = wordCounts.allObjects.sorted { wordCounts.count(for: $0) > wordCounts.count(for: $1) }
        allWords = sorted as! [String]
        //filteredWords = allWords
        applyUserFilter("swift")
    }
    
    func applyUserFilter(_ input: String) {
        if let userNumber = Int(input) {
            applyFilter { wordCounts.count(for: $0) >= userNumber}
        } else {
            applyFilter { $0.range(of: input, options: [.caseInsensitive]) != nil }
        }
    }
    
    private func applyFilter(_ filter: (String) -> Bool) {
        filteredWords = allWords.filter(filter)
    }
}
