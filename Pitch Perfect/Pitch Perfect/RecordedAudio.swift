//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jesse Martinez on 3/10/15.
//  Copyright (c) 2015 Jesse Martinez. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
    
    init(url: NSURL, title: String) {
        self.filePathUrl = url
        self.title = title
    }
}