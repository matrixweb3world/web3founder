import SwiftUI

struct SentimentAnalysisView: View {
    let positivePercentage: Double
    let neutralPercentage: Double
    let negativePercentage: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("情绪指标")
                .font(.headline)
                .foregroundColor(.blue)
                .padding(.bottom, 4)

            // 积极情绪
            ProgressBarView(
                value: positivePercentage,
                color: .green,
                label: "\(Int(positivePercentage * 100))%"
            )

            // 中性情绪
            ProgressBarView(
                value: neutralPercentage,
                color: .yellow,
                label: "\(Int(neutralPercentage * 100))%"
            )

            // 消极情绪
            ProgressBarView(
                value: negativePercentage,
                color: .red,
                label: "\(Int(negativePercentage * 100))%"
            )
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct ProgressBarView: View {
    var value: Double
    var color: Color
    var label: String

    var body: some View {
        HStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 24)
                        .opacity(0.1)
                        .foregroundColor(color)

                    Rectangle()
                        .frame(width: CGFloat(value) * geometry.size.width, height: 24)
                        .foregroundColor(color)
                }
                .cornerRadius(12)
            }
            .frame(height: 24)

            Text(label)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(color)
                .frame(width: 40)
        }
    }
}

// 预览
struct SentimentAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SentimentAnalysisView(
                positivePercentage: 0.65,
                neutralPercentage: 0.25,
                negativePercentage: 0.10
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("亮色模式")

            SentimentAnalysisView(
                positivePercentage: 0.65,
                neutralPercentage: 0.25,
                negativePercentage: 0.10
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
            .previewDisplayName("暗色模式")
        }
    }
}
