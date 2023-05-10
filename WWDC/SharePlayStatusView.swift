//
//  SharePlayStatusView.swift
//  SharePlayButtons
//
//  Created by Guilherme Rambo on 11/06/21.
//

import SwiftUI

@available(macOS 12.0, *)
enum SharePlayState: Int {
    case unavailable
    case inactive
    case loading
    case active
}

@available(macOS 12.0, *)
final class SharePlayStatusViewModel: ObservableObject {
    @Published var state: SharePlayState = .unavailable
}

@available(macOS 12.0, *)
struct SharePlayStatusView: View {
    @EnvironmentObject var viewModel: SharePlayStatusViewModel
    
    var handleClick: () -> Void
    
    var body: some View {
        Group {
            if viewModel.state != .unavailable {
                Button {
                    handleClick()
                } label: {
                    if viewModel.state == .loading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .controlSize(.small)
                    } else {
                        let color = viewModel.state == .active ? Color(nsColor: NSColor.controlAccentColor) : nil
                        
                        Image(systemName: "person.2.fill")
                            .foregroundColor(color)
                    }
                }
                .disabled(viewModel.state == .loading)
            }
        }
    }
}
