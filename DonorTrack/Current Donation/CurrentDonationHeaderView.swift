//
//  CurrentDonationHeaderView.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/20/21.
//
//
//import SwiftUI
//
//struct CurrentDonationHeaderView: View {
//	@Binding var currentDonation: Donation
//	@FocusState var focusedField: Field?
//
//    var body: some View {
//		HStack {
//			Text("Start:")
//			Text(currentDonation.startTime, style: .time)
//
//			Spacer()
//
//			HStack {
//				Text("Protein:")
//				TextField("Edit", text: $currentDonation.protein)
//					.frame(maxWidth: 25)
//			}
//			.foregroundColor(.blue)
//
//		}
//    }
//}

//struct CurrentDonationHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//		CurrentDonationHeaderView(currentDonation: Donation.previewData[0])
//			.previewLayout(.sizeThatFits)
//    }
//}
