//
//  VideoSectionViewModel.swift
//  IMDbApp
//
//  Created by Billy Joel on 22.01.2024.
//

import Foundation

struct VideoSectionViewModel {
    let type: VideoType
    let videos: [Video]
    let cellStyle: CellStyle
}

enum CellStyle {
    case vertical
    case horizontal
}
