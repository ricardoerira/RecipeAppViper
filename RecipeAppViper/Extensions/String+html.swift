//
//  String+Date.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 05/07/2023.
//

import Foundation
    
extension String {
   var htmlToAttributedString: NSAttributedString? {
       guard let data = data(using: .utf8) else { return nil }
       do {
           let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
               .documentType: NSAttributedString.DocumentType.html,
               .characterEncoding: String.Encoding.utf8.rawValue
           ]
           let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
           return attributedString
       } catch {
           return nil
       }
   }
}

