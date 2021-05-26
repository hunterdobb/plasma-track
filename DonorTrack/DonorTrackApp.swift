//
//  DonorTrackApp.swift
//  DonorTrack
//
//  Created by Hunter Dobbelmann on 5/10/21.
//

import SwiftUI

@main
struct DonorTrackApp: App {
	@ObservedObject private var data = DonationData()

	var body: some Scene {
		WindowGroup {
			ContentView(donations: $data.donations, data: data) {
				data.save()
			}
			.onAppear {
				data.load()
				print("Run")
			}
		}
		
	}
}
