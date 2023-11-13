//
//  ViewExtensions.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 11.10.2023.
//

import SwiftUI

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
