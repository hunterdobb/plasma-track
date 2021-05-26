//
//  CurrentDonationHeaderView.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/20/21.
//

import SwiftUI

struct CurrentDonationHeaderView: View {
	let currentDonation: Donation

    var body: some View {
		HStack {
			Text("Start:")
			Text(currentDonation.startTime, style: .time)

			Spacer()

			Text("Total:")
			Text(currentDonation.startTime, style: .timer)
		}
    }
}

struct CurrentDonationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
		CurrentDonationHeaderView(currentDonation: Donation.previewData[0])
			.previewLayout(.sizeThatFits)
    }
}
