//
//  FilterButtonView.swift
//  tweeter
//
//  Created by Luka Vuk on 16.06.2024..
//

import SwiftUI

enum TweetFilterOptions: Int, CaseIterable {
    case tweets, saved
    
    var title: String {
        switch self {
        case .tweets:
            return "Tweets"
        case .saved:
            return "Saved"
        }
    }
}

struct FilterButtonView: View {
    @Binding var selectedOption: TweetFilterOptions
    
    private let underlineWidth = UIScreen.main.bounds.width / 2
    
    private var padding: CGFloat {
        let rawValue = CGFloat(selectedOption.rawValue)
        return UIScreen.main.bounds.width / 2 * rawValue + 16
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(TweetFilterOptions.allCases, id: \.self) { option in
                    Button {
                        //do smth
                        self.selectedOption = option
                    } label: {
                        Text(option.title)
                            .frame(width: underlineWidth - 8)
                    }
                }
            }
            
            Rectangle()
                .frame(width: underlineWidth - 24, height: 3, alignment: .center)
                .padding(.leading, padding)
                .foregroundStyle(.blue)
                .animation(.spring)
        }
    }
}

#Preview {
    FilterButtonView(selectedOption: .constant(.tweets))
}
