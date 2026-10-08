# 命令清单

> 唯一来源：构建、测试与门禁命令。`CLAUDE.md` 只放速查。

## 项目生成

`project.yml` 是唯一配置来源，`Mochi.xcodeproj` 是生成物（已 gitignore，勿手改）。改动 `project.yml` 或增删源文件后：

```bash
xcodegen generate
```

## 构建与测试

```bash
xcodebuild -scheme Mochi -destination 'platform=macOS' build
xcodebuild -scheme Mochi -destination 'platform=macOS' test
# 单个测试（标识：Target/Suite/函数）
xcodebuild -scheme Mochi -destination 'platform=macOS' test -only-testing:MochiTests/MochiTests/example
```

测试日志中的 `linkd.autoShortcut` 连接错误是无害噪音。

## 门禁

```bash
scripts/check.sh               # xcodegen generate → build → test
scripts/check.sh --build-only  # 跳过测试
```

启用提交门禁（每个克隆需执行一次）：

```bash
git config core.hooksPath .githooks
```

`pre-commit` 会运行 `scripts/check.sh`。
