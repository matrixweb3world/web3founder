import SwiftUI

struct AIInsightView: View {
    let insights: [AIInsight]
    var onRefresh: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "brain")
                    .font(.system(size: 20))
                    .foregroundColor(.purple)

                Text("AI 解读")
                    .font(.headline)
                    .foregroundColor(.purple)
            }
            .padding(.horizontal)

            if insights.isEmpty {
                Text("暂无 AI 解读")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(insights) { insight in
                    HStack(alignment: .top) {
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 8, height: 8)
                            .padding(.top, 6)

                        Text(insight.text)
                            .font(.body)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal)
                }
            }

            Button(action: {
                onRefresh?()
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("刷新分析")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.purple.opacity(0.1))
                .foregroundColor(.purple)
                .cornerRadius(20)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

// 预览
struct AIInsightView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AIInsightView(insights: AIInsight.mockList())
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("有数据")

            AIInsightView(insights: [])
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("无数据")
        }
    }
}
