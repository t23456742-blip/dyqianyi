import SwiftUI

struct ContentView: View {
    @StateObject private var model = MigrateViewModel()

    private let accent = Color(red: 0.15, green: 0.85, blue: 0.78)
    private let card = Color(red: 0.11, green: 0.14, blue: 0.20)
    private let bgTop = Color(red: 0.05, green: 0.07, blue: 0.12)
    private let bgBottom = Color(red: 0.08, green: 0.10, blue: 0.16)

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            LinearGradient(colors: [bgTop, bgBottom], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 14) {
                    header
                    statusCard
                    buttons
                    Spacer(minLength: 48)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }

            Text("微信 pw68699")
                .font(.caption2.weight(.semibold))
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .padding(14)
        }
        .preferredColorScheme(.dark)
        .environment(\.locale, Locale(identifier: "zh_CN"))
        .onAppear { model.refreshSource() }
        .alert("提示", isPresented: $model.showResult) {
            Button("好的", role: .cancel) {}
        } message: {
            Text(model.resultText)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("票据迁移")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)
            Text("从抖音复制到目标 App · 巨魔专用")
                .font(.caption)
                .foregroundColor(.white.opacity(0.55))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var statusCard: some View {
        HStack {
            Image(systemName: model.sourceOK ? "checkmark.seal.fill" : "exclamationmark.triangle.fill")
                .foregroundColor(model.sourceOK ? accent : .orange)
            Text(model.sourceOK ? "抖音票据目录可用" : "未检测到抖音票据目录")
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.white)
            Spacer()
            Button("刷新") { model.refreshSource() }
                .font(.caption.weight(.bold))
                .foregroundColor(accent)
        }
        .padding(14)
        .background(card)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private var buttons: some View {
        VStack(spacing: 10) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(AppContainerLocator.migrateTargets) { app in
                    Button {
                        model.migrate(to: app)
                    } label: {
                        Text(app.title)
                            .font(.subheadline.weight(.bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color(red: 0.16, green: 0.22, blue: 0.32))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .disabled(model.isBusy)
                }
            }

            Button {
                model.migrateAll()
            } label: {
                HStack {
                    if model.isBusy {
                        ProgressView().tint(.white)
                    } else {
                        Image(systemName: "arrow.right.doc.on.clipboard")
                    }
                    Text("一键迁移到全部")
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    LinearGradient(
                        colors: [Color(red: 0.2, green: 0.75, blue: 0.55), Color(red: 0.15, green: 0.55, blue: 0.9)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .disabled(model.isBusy)
        }
    }
}

#Preview {
    ContentView()
}
