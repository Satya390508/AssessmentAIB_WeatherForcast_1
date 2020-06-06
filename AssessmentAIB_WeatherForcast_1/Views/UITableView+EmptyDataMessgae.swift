//
//  UITableView+EmptyDataMessgae.swift
//  AssessmentAIB_WeatherForcast_1
//
//  Created by SatyaRanjan Mohapatra on 06/06/20.
//  Copyright © 2020 SatyaranjanMohapatra. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
	
	open override func didMoveToWindow() {
		self.tableFooterView = UIView() // To remove unwanted empty cell at the bottom of table
	}
	
	func setEmptyMessage(_ message: String) {
		var tFrame = CGRect.zero
		tFrame.size = self.bounds.size
		let messageLabel = UILabel(frame: tFrame)
		messageLabel.text = message
		messageLabel.textColor = .black
		messageLabel.numberOfLines = 0;
		messageLabel.textAlignment = .center;
		messageLabel.sizeToFit()
		
		self.backgroundView = messageLabel;
	}
	
	func restore() {
		self.backgroundView = nil
	}
}
