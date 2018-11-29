//
//  CenterVCDelegate.swift
//  Tawsila
//
//  Created by ahmed gado on 11/29/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import Foundation
protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
