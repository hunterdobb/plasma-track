//
//  CurrentDonationView.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/17/21.
//

import SwiftUI

enum Field {
	case proteinField
	case cycleField
}

struct CurrentDonationView: View {
	static let tag: String? = "Current"
	@Binding var donations: [Donation]

	@State private var currentDonation = Donation(protein: "", cycles: [])
	@State private var newDonationsData = Donation.Data()

	@State private var newCycleAmount = ""
	@State private var protein = ""
	@FocusState private var focusedField: Field?

	@State private var editProtein = false

	@State private var currentCycleTime = Date()
	@State private var donationIsStarted = false

	let saveAction: () -> Void

	@ViewBuilder var donationHeader: some View {
		HStack {
			Text("Start:")
			Text(currentDonation.startTime, style: .time)

			Divider()

			HStack {
				Text("Protein:")

				TextField("None", text: $currentDonation.protein)
					.foregroundColor(.blue)
					.keyboardType(.decimalPad)
					.focused($focusedField, equals: .proteinField)
			}
			.onTapGesture { focusedField = .proteinField }
			.foregroundColor(.blue)
		}
	}

	@ViewBuilder var donationFooter: some View {
		if !currentDonation.cycles.isEmpty {
			HStack {
				Spacer()

				Text("Total:")
				Text(currentDonation.startTime, style: .timer)
			}
		}
	}

	var body: some View {
		NavigationView {
			Group {
				if donationIsStarted {
					VStack {
						List {
							Section(
								header: donationHeader,
								footer: donationFooter
							) {
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
									focusedField = .none
								}

								HStack {
									Text("\(currentDonation.cycles.count + 1)")
										.font(.caption)

									TextField("Total mL After Cycle", text: $newCycleAmount)
										.focused($focusedField, equals: .cycleField)
										.keyboardType(.numberPad)
										.font(.title2)

									Spacer()

									Text(currentCycleTime, style: .timer)
										.multilineTextAlignment(.center)
								}
								.onTapGesture {
									focusedField = .cycleField
									print("Tapped")
								}
							}
						}
						.navigationTitle(Text("Donating Now"))
						.listStyle(InsetGroupedListStyle())
//						.onTapGesture {
//							focusedField = .none
//						}
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
								focusedField = .cycleField
							}
						} label: {
							Text("Add Cycle")
								.bold()
								.font(.largeTitle)
								.frame(maxWidth: .infinity, minHeight: 60)
						}
						.foregroundColor(.white)
						.background(Color.blue)
						.cornerRadius(10)
						.padding([.leading, .trailing, .bottom], 6)
						.opacity(newCycleAmount.isEmpty ? 0.4 : 1.0)
						.disabled(newCycleAmount.isEmpty)
						.onAppear {
							focusedField = .cycleField
						}
					}
				} else {
					VStack {
						Spacer()

						Text("Enter your protein below to get started")
							.bold()

						Spacer()

						TextField("Protein", text: $protein)
							.padding()
							.focused($focusedField, equals: .cycleField)
							.textFieldStyle(RoundedBorderTextFieldStyle())
							.keyboardType(.decimalPad)

						Button {
							withAnimation {
								donationIsStarted = true
								currentCycleTime = Date()
								currentDonation.startTime = Date()
								currentDonation.protein = protein
								focusedField = .cycleField
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
					.onTapGesture {
						focusedField = .none
					}
				}
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
