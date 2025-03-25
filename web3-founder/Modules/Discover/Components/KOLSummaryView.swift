import SwiftUI

struct KOLSummaryView: View {
    let monitoringCount: Int
    let todayTweetsCount: Int
    let importantNoticesCount: Int

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                SummaryItemView(
                    title: "监控KOL",
                    value: "\(monitoringCount)",
                    iconName: "person.2"
                )

                Divider()
                    .background(Color.gray.opacity(0.3))

                SummaryItemView(
                    title: "今日推文",
                    value: "\(todayTweetsCount)",
                    iconName: "text.bubble"
                )

                Divider()
                    .background(Color.gray.opacity(0.3))

                SummaryItemView(
                    title: "重要通知",
                    value: "\(importantNoticesCount)",
                    iconName: "bell.badge"
                )
            }
            .frame(height: 100)
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct SummaryItemView: View {
    let title: String
    let value: String
    let iconName: String

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.gray)

            Text(value)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct KOLSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        KOLSummaryView(
            monitoringCount: 12,
            todayTweetsCount: 48,
            importantNoticesCount: 3
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
