//
//  HeartAnimationViewModel.swift
//  MetaViewDemo
//
//  Created by teneocto on 25/03/2024.
//

import Foundation
import ELCore

protocol HeartAnimationViewModelType: BaseViewModelType {
}

class HeartAnimationViewModel: HeartAnimationViewModelType {
  weak var coordinator: Coordinator?
}
