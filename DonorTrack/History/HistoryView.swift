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
	

//	var body: some View {
//		NavigationView {
//			List {
//				ForEach(donations) { donation in
//					Section(header: HistoryHeaderView(donation: donation)) {
//						CycleListView(donation: donation)
//					}
//				}
//			}
//			.listStyle(InsetGroupedListStyle())
//			.navigationTitle(Text("My Donations"))
//		}
//	}

	var body: some View {
		let calendar = Calendar.current

		NavigationView {
			List {
				ForEach(1...12, id: \.self) { month in
					Section(header: Text(calendar.monthSymbols[month-1])
								.font(.title2)
								.bold()
								.foregroundColor(.primary)
					) {
						ForEach(donations.filter({ (calendar.component(.month, from: $0.startTime) == month) })) { donation in
							NavigationLink {
								CycleListView(donation: donation)
							} label: {
								HistoryHeaderView(donation: donation)
							}
						}
					}
				}


			}
			.listStyle(.insetGrouped)
			.navigationTitle(Text("My Donations"))
			.navigationBarItems(
				trailing:
					Button {
				// action
			} label: {
				Image(systemName: "gear")
			})
		}
	}

	func numberOfDonorDaysInMonth(_ date: Date) -> Int {
		var firstDayCount = 0
		var secondDayCount = 0

		var calendar = Calendar(identifier: .gregorian)

		 calendar.firstWeekday = 3 // Tuesday
		 let weekRangeOne = calendar.range(of: .weekOfMonth,
										in: .month,
										for: date)

		firstDayCount = weekRangeOne!.count - 1

		calendar.firstWeekday = 6 // Friday
		let weekRangeTwo = calendar.range(of: .weekOfMonth,
									   in: .month,
									   for: date)

		secondDayCount = weekRangeTwo!.count - 1

		 return firstDayCount + secondDayCount
	}
}



struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
		HistoryView(donations: .constant(Donation.previewData))
    }
}
