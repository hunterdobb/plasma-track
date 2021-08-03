//
//  ContentView.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/17/21.
//

import SwiftUI

struct ContentView: View {
	@SceneStorage("selectedView") var selectedView: String?
	@Binding var donations: [Donation]
	@ObservedObject var data: DonationData
	let saveAction: () -> Void

	var body: some View {
		TabView(selection: $selectedView) {
			CurrentDonationView(donations: $donations) {
				data.save()
			}
				.tag(CurrentDonationView.tag)
				.tabItem {
					Image(systemName: "plus.circle.fill")
					Text("Donate Now")
				}

			HistoryView(donations: $donations)
				.tag(HistoryView.tag)
				.tabItem {
					Image(systemName: "calendar.circle.fill")
					Text("My Donations")
				}
		}
	}

//	private func getBinding() -> Binding<Donation> {
//		guard let donationIndex = donations.firstIndex(where: { $0.isFinished == false }) else {
////			fatalError("Can't find donation in array")
//			return $donations[0]
//		}
//
//		return $donations[donationIndex]
//	}
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//		ContentView(donations: .constant(Donation.previewData), saveAction: {})
//    }
//}
