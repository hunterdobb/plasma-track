//
//  CurrentDonationView.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/17/21.
//

import SwiftUI

struct CurrentDonationView: View {
	static let tag: String? = "Current"
	@Binding var donations: [Donation]

	@State private var currentDonation = Donation(protein: "N/A", cycles: [])
	@State private var newDonationsData = Donation.Data()
	@State private var newCycleAmount = ""
	@State private var protein = ""
	@State private var currentCycleTime = Date()
	@State private var donationIsStarted = false
	let saveAction: () -> Void

	var body: some View {
		NavigationView {
			if donationIsStarted {
				VStack {
					List {
						Section(header: CurrentDonationHeaderView(currentDonation: currentDonation)) {
							ForEach(currentDonation.cycles.indices, id: \.self) { i in
								let cycle = currentDonation.cycles[i]
								let cycleCount = i + 1
								HStack {
									Text("\(cycleCount)")
										.font(.caption)

									Text("\(cycle.totalAmount)")
										.font(.title2)
										.bold()

									Text("\(currentDonation.getCycleAmount(for: i))")

									Spacer()

									Text(cycle.minuteSecondsString)
								}
							}
							.onTapGesture {
								hideKeyboard()
							}

							HStack {
								Text("\(currentDonation.cycles.count + 1)")
									.font(.caption)

								TextField("Total After Cycle", text: $newCycleAmount)
									.keyboardType(.numberPad)
									.font(.title2)


								Spacer()

								Text(currentCycleTime, style: .timer)
									.multilineTextAlignment(.center)

							}
						}
					}
					.navigationTitle(Text("Donating Now"))
					.listStyle(InsetGroupedListStyle())
					.onTapGesture {
						hideKeyboard()
					}
					.navigationBarItems(trailing: Button("Finish") {
						donationIsStarted = false
						protein = ""
						currentDonation.finishTime = Date()
						donations.insert(currentDonation, at: 0)
						saveAction()
						newDonationsData = Donation.Data()
					})

					Button {
						withAnimation {
							addCycle(amount: newCycleAmount, lengthInSeconds: Int(Date().timeIntervalSince(currentCycleTime)))
							newCycleAmount = ""
						}
					} label: {
						Text("Add Cycle")
							.bold()
							.font(.largeTitle)
							.frame(maxWidth: .infinity, minHeight: 65)
					}
					.foregroundColor(.white)
					.background(Color.blue)
					.cornerRadius(10)
					.padding(.bottom)
					.padding([.leading, .trailing], 6)
					.opacity(newCycleAmount.isEmpty ? 0.4 : 1.0)
					.disabled(newCycleAmount.isEmpty)
				}
			} else {
				VStack {
					Spacer()

					TextField("Protein", text: $protein)
						.padding()
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.decimalPad)
						.onTapGesture {
							hideKeyboard()
						}

					Button {
						withAnimation {
							donationIsStarted = true
							currentCycleTime = Date()
							currentDonation.startTime = Date()
							currentDonation.protein = protein
						}
					} label: {
						Text("Start New Donation")
							.bold()
							.font(.largeTitle)
							.frame(maxWidth: .infinity, minHeight: 65)
					}
					.foregroundColor(.white)
					.background(Color.blue)
					.cornerRadius(10)
					.padding([.leading, .trailing, .bottom], 6)
					.opacity(protein.isEmpty ? 0.4 : 1.0)
					.disabled(protein.isEmpty)
				}
				.navigationTitle(Text("Donate Now"))

			}
		}
	}

	func addCycle(amount: String, lengthInSeconds: Int) {
		if let newAmount = Int(amount) {
			currentDonation.cycles.append(Cycle(totalAmount: newAmount, lengthInSeconds: lengthInSeconds))
		}

		currentCycleTime = Date()
	}
}

#if canImport(UIKit)
extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
#endif




struct CurrentDonationView_Previews: PreviewProvider {
    static var previews: some View {
		CurrentDonationView(donations: .constant(Donation.previewData), saveAction: {})
    }
}
