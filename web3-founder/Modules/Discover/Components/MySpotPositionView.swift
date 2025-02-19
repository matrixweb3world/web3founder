import SwiftUI

struct MySpotPositionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("My SPOT Position")
                .font(.headline)
            HStack {
                VStack {
                    Text("Shares")
                    Text("0.17469")
                }
                Spacer()
                VStack {
                    Text("Avg. Cost")
                    Text("$73.86")
                }
            }
            HStack {
                VStack {
                    Text("Equity")
                    Text("$22,935.46")
                }
                Spacer()
                VStack {
                    Text("Total Returns")
                    Text("$1,946.75")
                }
            }
        }
    }
} 