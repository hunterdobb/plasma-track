//
//  CycleListView.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/20/21.
//

import SwiftUI

struct CycleListView: View {
	let donation: Donation

    var body: some View {
		List {
			ForEach(donation.cycles.indices) { i in
				let cycle = donation.cycles[i]
				let cycleCount = i + 1

				HStack {
					Text("\(cycleCount)")
						.font(.caption)

					Text("\(cycle.totalAmount)")
						.font(.title2)
						.bold()
						.frame(minWidth: 50)

					Text("\(donation.getCycleAmount(for: i))")
						.frame(minWidth: 50)

					Spacer()

					Text(cycle.minuteSecondsString)
				}
			}
		}
		.listStyle(.insetGrouped)
		.navigationTitle(Text(donation.startTime, style: .date))
		.navigationBarTitleDisplayMode(.inline)
    }
}

struct CycleListView_Previews: PreviewProvider {
    static var previews: some View {
		List {
			CycleListView(donation: Donation.previewData[0])
				.previewLayout(.sizeThatFits)
		}
		.listStyle(InsetGroupedListStyle())
    }
}
