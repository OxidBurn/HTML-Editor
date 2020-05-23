//
//  HTMLService.swift
//  HTML Editor
//
//  Created by Nikolay Chaban on 23.05.2020.
//  Copyright © 2020 Nikolay Chaban. All rights reserved.
//

import Foundation
import UIKit

protocol HTMLService {
    
    func loadLocalHTMLFile() -> NSAttributedString
    
    func saveHTMLFile(_ content: NSAttributedString)
}

class HTMLServiceImp: HTMLService {
    
    //MARK: - Properties -
    let htmlFilePath  : String = Bundle.main.path(forResource  : "source", ofType  : "htm") ?? ""
    let storeFilePath : URL = URL(fileURLWithPath: NSTemporaryDirectory() + "result.html")
    
    
    //MARK: - Public methods -
    func loadLocalHTMLFile() -> NSAttributedString {
        do {
            let content = try String(contentsOfFile: htmlFilePath, encoding: .utf8)
            
            let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)
            ]
            
            guard let data = content.data(using: .utf8) else { return NSAttributedString()}
            
            var attributedText: NSMutableAttributedString!
            do {
                attributedText = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            } catch {
                print("Error with converting content to the attributed string: \(error)")
            }

            // This attribute fixes the alignment problem for Arabic language
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.alignment = .right
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            
            return attributedText
        } catch {
            print("Error with loading file: \(error)")
        }
        
        
        return NSAttributedString()
    }
    
    func saveHTMLFile(_ content: NSAttributedString) {
        do {
            let wholeRange = NSRange(content.string.startIndex..., in: content.string)
            let htmlData = try content.data(from: wholeRange,
                                            documentAttributes: [.documentType: NSAttributedString.DocumentType.html])
            do {
                try htmlData.write(to: storeFilePath, options: .atomic)
            } catch {
                print("Error with HTML recording file: \(error)")
            }
        } catch {
            print("Error with obtain html data from attributed string: \(error)")
        }
    }
}
