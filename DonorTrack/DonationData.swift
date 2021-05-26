//
//  DonationData.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/11/21.
//

import Foundation

class DonationData: ObservableObject {
	private static var documentsFolder: URL {
		do {
			return try FileManager.default.url(
				for: .documentDirectory,
				in: .userDomainMask,
				appropriateFor: nil,
				create: false
			)
		} catch {
			fatalError("Can't find documents directory")
		}
	}

	private static var fileURL: URL {
		documentsFolder.appendingPathComponent("donations.data")
	}

	@Published var donations: [Donation] = []
	@Published var isDonating = false

	func load() {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let data = try? Data(contentsOf: Self.fileURL) else {
				#if DEBUG
				DispatchQueue.main.async {
					print("Queue")
					self?.donations = Donation.previewData
				}
				#endif

				return
			}

			guard let donations = try? JSONDecoder().decode([Donation].self, from: data) else {
				fatalError("Can't decode saved donation data")
			}

			DispatchQueue.main.async {
				self?.donations = donations
			}
		}
	}

	func save() {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let donations = self?.donations else { fatalError("Self out of scope") }
			guard let data = try? JSONEncoder().encode(donations) else { fatalError("Error encoding data") }

			do {
				let outfile = Self.fileURL
				try data.write(to: outfile)
			} catch {
				fatalError("Can't write to file")
			}
		}
	}
}
