//
//  Donation.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/10/21.
//

import SwiftUI

struct Donation: Identifiable, Codable {
	let id: UUID
	var protein: String
	var cycles: [Cycle]
	var startTime: Date
	var finishTime: Date

//	static var isDonating = false

	private var totalLengthInSeconds: Int {
		var total = 0

		for cycle in cycles {
			total += cycle.lengthInSeconds
		}

		return total
	}

//	var cycleCount: Int {
//		cycles.count
//	}

	var averageCycleTimeString: String {
		let average = totalLengthInSeconds / cycles.count

		let calcSeconds = (average % 3600) % 60
		let calcMinutes = (average % 3600) / 60
		return ("\(calcMinutes)m \(calcSeconds)s")
	}

	var totalTimeString: String {
		let total = Int(finishTime.timeIntervalSince(startTime))

		let calcSeconds = (total % 3600) % 60
		let calcMinutes = (total % 3600) / 60
		return ("\(calcMinutes)m \(calcSeconds)s")
	}

	init(id: UUID = UUID(), protein: String, cycles: [Cycle], startTime: Date = Date(), finishTime: Date = Date()) {
		self.id = id
		self.protein = protein
		self.cycles = cycles
		self.startTime = startTime
		self.finishTime = finishTime
	}

	mutating func addCycle(totalAmount: Int, lengthInSeconds: Int) {
		self.cycles.append(Cycle(totalAmount: totalAmount, lengthInSeconds: lengthInSeconds))
	}

	func getCycleAmount(for index: Int) -> Int {
		if index == 0 {
			return cycles[0].totalAmount
		} else {
			return cycles[index].totalAmount - cycles[index - 1].totalAmount
		}
	}
}

extension Donation {
	static var previewData: [Donation] {
		[
			Donation(
				protein: "6.5",
				cycles: [
					Cycle(totalAmount: 78, lengthInSeconds: 180),
					Cycle(totalAmount: 175, lengthInSeconds: 172),
					Cycle(totalAmount: 275, lengthInSeconds: 172),
					Cycle(totalAmount: 373, lengthInSeconds: 172),
					Cycle(totalAmount: 466, lengthInSeconds: 172),
					Cycle(totalAmount: 556, lengthInSeconds: 172),
					Cycle(totalAmount: 640, lengthInSeconds: 172)
				]
			),
			Donation(
				protein: "6.2",
				cycles: [
					Cycle(totalAmount: 72, lengthInSeconds: 180),
					Cycle(totalAmount: 159, lengthInSeconds: 172),
					Cycle(totalAmount: 253, lengthInSeconds: 172),
					Cycle(totalAmount: 343, lengthInSeconds: 172),
					Cycle(totalAmount: 432, lengthInSeconds: 172),
					Cycle(totalAmount: 514, lengthInSeconds: 172),
					Cycle(totalAmount: 594, lengthInSeconds: 172),
					Cycle(totalAmount: 671, lengthInSeconds: 172),
					Cycle(totalAmount: 690, lengthInSeconds: 172)
				]
			)
		]
	}
}

extension Donation {
	struct Data {
		var protein = ""
		var cycles: [Cycle] = []
		var startTime = Date()
		var finishTime = Date()
	}

	var data: Data {
		Data(protein: protein, cycles: cycles, startTime: startTime, finishTime: finishTime)
	}

	mutating func update(from data: Data) {
		protein = data.protein
		cycles = data.cycles
		startTime = data.startTime
		finishTime = data.finishTime
	}
}
