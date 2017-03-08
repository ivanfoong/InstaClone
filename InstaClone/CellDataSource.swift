//
//  CellDataSource.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/8/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import Foundation

protocol CellDataSource {
    func configureCell(with data: BaseCellData)
}
