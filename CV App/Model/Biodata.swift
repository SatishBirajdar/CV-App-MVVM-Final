//
//  Biodata.swift
//  CV App
//
//  Created by Satish Birajdar on 2019-07-18.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import Foundation

struct Biodata: Decodable {
    var name: String
    var profilePicture: String
    var contactDetails: String
    var professionalSummary: String
    var skills: String
    var experiences: [Experience]
}

