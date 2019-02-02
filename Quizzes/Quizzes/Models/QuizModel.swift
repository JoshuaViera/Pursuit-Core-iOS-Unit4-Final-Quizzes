//
//  QuizModel.swift
//  Quizzes
//
//  Created by Joshua Viera on 2/2/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct Quiz : Codable {
    let description: String
    let createdAt: String
    
    public var dateFormattedString: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = createdAt
        if let date = isoDateFormatter.date(from: createdAt){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
            
        }
        return formattedDate
    }
    public var date: Date{
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = Date()
        if let date = isoDateFormatter.date(from: createdAt){
            formattedDate  = date
        }
        return formattedDate
    }
}

final class QuizModel {
    
    private static let filename = "QuizList.plist"
    private static var quizzes = [Quiz]()
    
    static func getItems() -> [Quiz] {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    quizzes = try PropertyListDecoder().decode([Quiz].self, from: data)
                } catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        quizzes = quizzes.sorted{$0.date > $1.date}
        return quizzes
    }
    
    static func addItem(item: Quiz) {
        quizzes.append(item)
        save()
    }
    
    static func save() {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(quizzes)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoder error: \(error)")
        }
    }
    
    static func delete(atIndex index: Int) {
        quizzes.remove(at: index)
        save()
    }
    static func update(newItem:Quiz, atIndex: Int) {
        quizzes[atIndex] = newItem
        save()
    }
    
    
}
