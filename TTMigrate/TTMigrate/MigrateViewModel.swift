import Foundation
import Combine

@MainActor
final class MigrateViewModel: ObservableObject {
    @Published var isBusy = false
    @Published var sourceOK = false
    @Published var showResult = false
    @Published var resultText = ""

    func refreshSource() {
        guard let hit = AppContainerLocator.locateContainer(bundleIDs: AppContainerLocator.douyin.bundleIDs) else {
            sourceOK = false
            return
        }
        let dir = hit.url.appendingPathComponent(InstallDocMigrator.relativeDir, isDirectory: true)
        sourceOK = FileManager.default.fileExists(atPath: dir.path)
    }

    func migrate(to target: TargetApp) {
        guard !isBusy else { return }
        isBusy = true
        Task.detached(priority: .userInitiated) {
            let result = InstallDocMigrator.migrate(to: target)
            await MainActor.run {
                self.isBusy = false
                self.resultText = result.message
                self.showResult = true
            }
        }
    }

    func migrateAll() {
        guard !isBusy else { return }
        isBusy = true
        Task.detached(priority: .userInitiated) {
            let result = InstallDocMigrator.migrateAll()
            await MainActor.run {
                self.isBusy = false
                self.resultText = result.message
                self.showResult = true
            }
        }
    }
}
