//
//  Biodata.swift
//  CV App
//
//  Created by Satish Birajdar on 2019-07-18.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import Foundation

struct Biodata: Codable {
    var name: String
    var contactDetails: String
    var professionalSummary: String
    var skills: String
    var experiences: [Experience]
}

