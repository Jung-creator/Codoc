//
//  Font+Extension.swift
//  Codoc
//
//  Created by Choi Jung In on 8/23/25.
//

import SwiftUI

internal enum FontStyle {
  case regular1, regular2, regular3
  case medium1, medium2, medium3
  case bold1, bold2, bold3, bold4, bold5
  
  var font: Font {
    switch self {
    case .regular1: return .custom("Pretendard-Regular", size: 10)
    case .regular2: return .custom("Pretendard-Regular", size: 12)
    case .regular3: return .custom("Pretendard-Regular", size: 14)
      
    case .medium1: return .custom("Pretendard-Medium", size: 14)
    case .medium2: return .custom("Pretendard-Medium", size: 16)
    case .medium3: return .custom("Pretendard-Medium", size: 18)
      
    case .bold1: return .custom("Pretendard-Bold", size: 12)
    case .bold2: return .custom("Pretendard-Bold", size: 16)
    case .bold3: return .custom("Pretendard-Bold", size: 20)
    case .bold4: return .custom("Pretendard-Bold", size: 24)
    case .bold5: return .custom("Pretendard-Bold", size: 32)
    }
  }
  
  var lineSpacing: CGFloat {
    switch self {
    default: return self.fontSize * 0.2
    }
  }
  
  private var fontSize: CGFloat {
    switch self {
    case .regular1: return 10
    case .regular2: return 12
    case .regular3: return 14
        
    case .medium1: return 14
    case .medium2: return 16
    case .medium3: return 18
        
    case .bold1: return 16
    case .bold2: return 18
    case .bold3: return 20
    case .bold4: return 24
    case .bold5: return 28
    }
  }
}
