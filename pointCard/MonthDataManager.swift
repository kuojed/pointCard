//
//  MonthDataManager.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/8/15.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import Foundation

class MonthDataManager: ObservableObject {
    @Published var month = "empty"
    @Published var year = "empty"
    @Published var count = 0
}
