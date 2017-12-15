//
//  Functions.swift
//  Weather
//
//  Created by Tanya Tomchuk on 26/11/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import Foundation

let applicationDocumentsDirectory: URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}()
