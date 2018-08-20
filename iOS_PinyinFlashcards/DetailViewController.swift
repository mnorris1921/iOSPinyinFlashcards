//
//  DetailViewController.swift
//  iOS_PinyinFlashcards
//
//  Created by Michael Norris on 8/5/18.
//  Copyright © 2018 Michael Norris. All rights reserved.
//

import UIKit

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

class DetailViewController: UIViewController {
    var isChineseToEnglish = true
    var shuffled = [[String]]()
    var currentRow = [String]()
    var currentIndex = 0
    var csv : [[String]]!
    var myTitle: String?

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func goPrevious(_ sender: Any) {
        if currentIndex > 0 {
            repeat {
                currentIndex = currentIndex - 1
            } while (currentIndex > 0 && currentIndex < shuffled.count && (shuffled[currentIndex][0]).isEmpty)
            
            updateWord()
        }
    }
    
    @IBAction func goNext(_ sender: Any) {
        repeat {
            currentIndex = currentIndex + 1
        } while (currentIndex < shuffled.count &&
            (shuffled[currentIndex][0]).isEmpty)
        
        if (currentIndex >= shuffled.count) {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            updateWord()
        }
    }
    
    @IBAction func changeLanguage(_ sender: Any) {
        isChineseToEnglish = !isChineseToEnglish
        updateWord()
    }
    
    func configureView() {
        prevButton.titleLabel?.isHidden = true
        nextButton.titleLabel?.isHidden = true
        self.view.layoutIfNeeded()

        let str = readDataFromCSV()
        self.csv = csv(data: str!)

        shuffled = csv.shuffled()

        word.lineBreakMode = .byWordWrapping
        word.numberOfLines = 0
        word.font = UIFont(name: word.font!.fontName, size: 40)
        word.textAlignment = .center
        
        notes.lineBreakMode = .byWordWrapping
        word.numberOfLines = 0

        currentIndex = 0
        updateWord()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func csv (data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
    func readDataFromCSV () -> String! {
        var contents = ""
            
        let filePath = Bundle.main.url(forResource: myTitle!, withExtension: "csv")
        do {
            contents = try NSString(contentsOf: filePath!, encoding: String.Encoding.utf8.rawValue) as String
        }
        catch {
            print("could not find file at path")
        }
        return contents
    }
    
    
    func cleanRows (file:String) -> String {
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
        return cleanFile
    }

    func updateWord () {
        if (currentIndex >= shuffled.count) {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            currentRow = shuffled[currentIndex]
            if (isChineseToEnglish) {
                word.text = currentRow[0]
            }
            else {
                word.text = currentRow[1]
            }
            if currentRow.count > 2 {
                notes.text = "Notes: " + currentRow[2]
            }
        }
    }
}

