//    "https://api.myjson.com/bins/1ebnfa" //"https://raw.githubusercontent.com/akarsh/akarsh.github.io/master/json/en/resume.json"
//    "https://api.myjson.com/bins/1ebnfa"
//"https://gist.github.com/JeroenDunselman/RESUME.JSON" //
//
//  DataService.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 06/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    var filePath = "", resumeFileName = "resume.json"
    var storage: Resume?
    
    let imageFileName = "standard_profile.jpg"
    var profilePicture = UIImage()
    
    // URL for the resume JSON files located in GitHub
    //editable at:    https://github.com/JeroenDunselman/resume/edit/master/resume.json
    let resumeURL = "https://jeroendunselman.github.io/resume/resume.json"

    func fetch() -> Bool {
        self.fetchData()
        
        let failAfter = 10
        var failCount = 0
        while storage == nil && failCount < failAfter {
            failCount += 1
            
            self.read()
            
            print("sleeping")
            sleep(1)
        }
        self.downloadImageFromURL()
        return !(storage == nil)
    }
    
    func fetchData() {
        self.fetchData(self.resumeFileName, self.resumeURL)
    }
    
    func fetchData(_ resumeFileName: String, _ resumeURL: String) {
        // Create destination URL
        let documentsUrl: URL = DocumentHelper.getDocumentsDirectory()
        // Get the file path in documents directory
        
        let destinationFileUrl = documentsUrl.appendingPathComponent(resumeFileName)
        // Find documents directory on device
        let dirs: [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        
        do {
            if dirs.count > 0 {
                // documents directory
                let dir = dirs[0]
                // adding the filename to the documents directory as file path
                self.filePath = dir.appendingFormat("/" + resumeFileName)
                // delete the file if it exists
                if FileManager.default.fileExists(atPath: self.filePath) {
                    try FileManager.default.removeItem(atPath: self.filePath)
                }
            } else {
                print("Could not find local directory to store file")
                return
            }
        } catch let error as NSError {
            print("An error took place: \(error.localizedDescription)")
        }
        // url to the resume JSON file

        DownloadHelper.downloadFromURL(resumeURL, destinationFileUrl)
    }
    
    func read() {
       readData { basicsStorage in
        self.storage = basicsStorage }
    }
    
    // read the JSON data file
    func readData(completionHandler: @escaping (Resume) -> Void) {
        // Find documents directory on device
        let dirs: [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        
        do {
            if dirs.count > 0 {
                // documents directory
                let dir = dirs[0]
                // adding the filename to the documents directory as file path
                self.filePath = dir.appendingFormat("/" + self.resumeFileName)
                // Read file content
                let contentFromFile = try String(contentsOfFile: self.filePath, encoding: String.Encoding.utf8)
                let jsonDataParsed = contentFromFile.data(using: .utf8)!
                let jsonDecoder = JSONDecoder()
                do {
                    let basicsStorage = try jsonDecoder.decode(Resume.self, from: jsonDataParsed)
                    completionHandler(basicsStorage)
                } catch {
                    print("Could not decode to basicsStorage")
                }
            } else {
                print("Could not find local directory to store file")
                return
            }
        } catch let error as NSError {
            print("An error took place: \(error)")
        }
    }
    
    func downloadImageFromURL() {
        guard let url = storage?.basics.picture else { return }
        // Create destination URL
        let documentsUrl: URL = DocumentHelper.getDocumentsDirectory()
        // Get the file path in documents directory
        let destinationFileUrl = documentsUrl.appendingPathComponent(self.imageFileName)
        // get the documents directory url
        let dirs: [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        if dirs.count > 0 {
            // documents directory
            let dir = dirs[0]
            // adding the filename to the documents directory as file path
            self.filePath = dir.appendingFormat("/" + self.imageFileName)
            // check if the file does not exists
            if !FileManager.default.fileExists(atPath: self.filePath) {
                // url to the resume JSON file
                DownloadHelper.downloadFromURL(url, destinationFileUrl)
            }
        } else {
            print("Could not find local directory to store file")
            return
        }
    }
    
    // read the picture data file
    func setImageViewToImageFile() {
        // Find documents directory on device
        let dirs: [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        if dirs.count > 0 {
            // documents directory
            let dir = dirs[0]
            // adding the filename to the documents directory as file path
            filePath = dir.appendingFormat("/" + imageFileName)
            // set the file to imageView
            if let image = UIImage(contentsOfFile: filePath) {
                profilePicture = image
            }
            
        } else {
            print("Could not find local directory to store file")
            return
        }
    }
}
