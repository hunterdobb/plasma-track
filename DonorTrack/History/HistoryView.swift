//
//  HistoryView.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/10/21.
//

import SwiftUI

struct HistoryView: View {
	static let tag: String? = "History"
	@Binding var donations: [Donation]
//	let saveAction: () -> Void
//	@State private var newCycleData = Donation.Data().cycles
//	@State private var newAmount = ""
	

	var body: some View {
		NavigationView {
			List {
				ForEach(donations) { donation in
					Section(header: HistoryHeaderView(donation: donation)) {
						CycleListView(donation: donation)
					}
				}
			}
			.listStyle(InsetGroupedListStyle())
			.navigationTitle(Text("History"))
		}
	}
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
		HistoryView(donations: .constant(Donation.previewData))
    }
}
