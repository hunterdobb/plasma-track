//
//  HistoryHeaderView.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/20/21.
//

import SwiftUI

struct HistoryHeaderView: View {
	let donation: Donation

	static let donationDateFormat: DateFormatter = {
			let formatter = DateFormatter()
			formatter.dateFormat = "EEEE"
			return formatter
		}()

    var body: some View {
		HStack {
			VStack(alignment: .leading) {
				HStack {
					Text("\(donation.startTime, formatter: Self.donationDateFormat)")
						.bold()
					Text("(\(donation.totalTimeString))")
				}

				HStack {
					Text(donation.startTime, style: .time)
					Text("-")
					Text(donation.finishTime, style: .time)
				}
			}

			Spacer()

			VStack(alignment: .trailing) {
				Text("Average: \(donation.averageCycleTimeString)")
				Text("Protein: \(donation.protein)")
			}
		}
    }
}

struct HistoryHeaderView_Previews: PreviewProvider {
    static var previews: some View {
		HistoryHeaderView(donation: Donation.previewData[0])
			.previewLayout(.sizeThatFits)
    }
}
