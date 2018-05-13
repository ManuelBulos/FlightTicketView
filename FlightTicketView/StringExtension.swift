//
//  StringExtension.swift
//
//  Created by Manuel Bulos on 5/10/18.
//  Copyright © 2018 Bulos. All rights reserved.
//

import Foundation

extension String {
    
    func shortenName() -> String { return String(describing: self.dropLast(self.count - 3)).uppercased() }
    
}
