//
//  DataManager.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class DataManager {
    
    static let shared = DataManager()
    
    func createData(movie: Movie) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedcontext = appDelegate.persistentContainer.viewContext
        guard let movieIdEntity = NSEntityDescription.entity(forEntityName: "MovieEntity",
                                                             in: managedcontext) else { return }
        let newMovie = NSManagedObject(entity: movieIdEntity,
                                       insertInto: managedcontext)
        newMovie.setValue(movie.id, forKey: "id")
        newMovie.setValue(movie.overview, forKey: "overview")
        newMovie.setValue(movie.posterPath, forKey: "posterPath")
        newMovie.setValue(movie.releaseDate, forKey: "releaseDate")
        newMovie.setValue(movie.title, forKey: "title")
        newMovie.setValue(movie.genreIds, forKey: "genres")
        
        do {
            try managedcontext.save()
        } catch let error as NSError {
            print("id: \(movie.id), \n error: \(error),  \n userInfo error: \(error.userInfo)")
        }
    }
    
    func getData() -> [Movie]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedcontext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        var results: [Movie] = []
        do {
            let result = try managedcontext.fetch(fetchRequest)
            guard let objectsResults = result as? [NSManagedObject] else { return nil }
            for data in objectsResults {
                guard let movieId = data.value(forKey: "id") as? Int,
                    let overview = data.value(forKey: "overview") as? String,
                    let posterPath = data.value(forKey: "posterPath") as? String,
                    let releaseDate = data.value(forKey: "releaseDate") as? String,
                    let title = data.value(forKey: "title") as? String,
                    let genres = data.value(forKey: "genres") as? [Int]
                    else { return nil }
                let movie = Movie(popularity: 0.0,
                                  voteCount: 1,
                                  video: false,
                                  posterPath: posterPath,
                                  id: movieId,
                                  adult: false,
                                  backdropPath: "",
                                  originalLanguage: "",
                                  originalTitle: "",
                                  genreIds: genres,
                                  title: title,
                                  voteAverage: 1.0,
                                  overview: overview,
                                  releaseDate: releaseDate)
                results.append(movie)
            }
        } catch let error {
            print("Failed \(error)")
        }
        return results
    }
    
    func deleteData(movieId: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedcontext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        
        do {
            let result = try managedcontext.fetch(fetchRequest)
            guard let results = result as? [NSManagedObject] else { return }
            var objectToDelete: NSManagedObject?

            for data in results where (data.value(forKey: "id") as? Int) == movieId {
                objectToDelete = data
            }
            guard let object = objectToDelete else { return }
            managedcontext.delete(object)
            do {
                try managedcontext.save()
            } catch let error {
                print("Failed \(error)")
            }
        } catch let error {
            print("Failed \(error)")
        }
    }
    
    func checkData(movieId: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedcontext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        
        do {
            let result = try managedcontext.fetch(fetchRequest)
            guard let results = result as? [NSManagedObject] else { return false }
            for data in results where (data.value(forKey: "id") as? Int) == movieId {
                return true
            }
        } catch let error {
            print("Failed \(error)")
        }
        
        return false
    }
}
