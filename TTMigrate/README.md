# 票据迁移 · 巨魔插件

独立 tipa：**只做** 抖音 `Documents/_ttinstall_document` → 目标 App 同名目录迁移。

- 显示名：**票据迁移**
- Bundle ID：`com.ttmigrate.plugin`
- 环境：TrollStore / 巨魔 · Dopamine RootHide · iOS 15+

## 支持目标

| App | Bundle ID |
|-----|-----------|
| 抖音极速版 | `com.ss.iphone.ugc.Aweme.lite` 等 |
| 抖音火山版 | `com.ss.iphone.ugc.live` 等 |
| 抖音商城 | `com.ss.android.ugc.live.shop` |
| 抖省省 | `com.ss.android.ugc.lifeservices` |
| 头条 | `com.ss.iphone.article.News` |
| 多闪 | `com.ss.iphone.ugc.Duoshan` |
| **番茄小说** | **`com.dragon.read`** |

来源固定为抖音：`com.ss.iphone.ugc.Aweme`。

成功弹窗只显示「成功」，失败只显示「失败」。

## 编译

GitHub：**Actions → Build TIPA → Run workflow**，下载 `TTMigrate-tipa`。

本地（macOS）：

```bash
brew install xcodegen ldid
xcodegen generate
xcodebuild -project TTMigrate.xcodeproj -scheme TTMigrate \
  -configuration Release -sdk iphoneos -derivedDataPath build \
  CODE_SIGNING_ALLOWED=NO CODE_SIGN_IDENTITY="" build
bash scripts/package-tipa.sh
```

产物：`dist/TTMigrate.tipa`
