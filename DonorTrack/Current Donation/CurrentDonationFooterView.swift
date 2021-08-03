//
//  CurrentDonationFooterView.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/26/21.
//

import SwiftUI

struct CurrentDonationFooterView: View {
	let currentDonation: Donation

	var body: some View {
		if !currentDonation.cycles.isEmpty {
			HStack {
				Spacer()

				Text("Total:")
				Text(currentDonation.startTime, style: .timer)
			}
		}
	}
}

struct CurrentDonationFooterView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentDonationFooterView(currentDonation: Donation.previewData[0])
			.previewLayout(.sizeThatFits)
    }
}
