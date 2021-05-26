//
//  Cycle.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/10/21.
//

import SwiftUI

struct Cycle: Identifiable, Codable {
	let id: UUID
	var totalAmount: Int
	var lengthInSeconds: Int

	var minuteSecondsString: String {
		let calcSeconds = (lengthInSeconds % 3600) % 60
		let calcMinutes = (lengthInSeconds % 3600) / 60
		return ("\(calcMinutes)m \(calcSeconds)s")
	}

	init(id: UUID = UUID(), totalAmount: Int, lengthInSeconds: Int) {
		self.id = id
		self.totalAmount = totalAmount
		self.lengthInSeconds = lengthInSeconds
	}
}
