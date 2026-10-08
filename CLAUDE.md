# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Mochi 是一个 macOS SwiftUI app（README 仅写 "musician"，产品方向未定，目前只有模板代码）。最低 macOS 15、Swift 6、App Sandbox、ad-hoc 签名（无需开发者账号）。

> 规范细节全部位于 `guidelines/`（本文件底部 @import）。本文件只保留速查和 agent 行为指令，细则一律引用既有规范，禁止在此复写。

## 命令速查

```bash
xcodegen generate                                    # 改 project.yml / 增删源文件后必须执行
scripts/check.sh                                     # 门禁：generate → build → test
xcodebuild -scheme Mochi -destination 'platform=macOS' build
xcodebuild -scheme Mochi -destination 'platform=macOS' test -only-testing:MochiTests/MochiTests/example
```

命令权威清单唯一来源：`guidelines/commands.md`。

## 门禁运行策略

每次改动后只运行与改动相关的检查：只改视图跑 `build`，改逻辑跑相关 `-only-testing`。全量 `scripts/check.sh` 必须先征得用户同意。

## 快速参考

- **项目配置**：`project.yml` 是唯一来源，`Mochi.xcodeproj` 为生成物、已 gitignore，禁止手改
- **Target**：`Mochi`（源码 `Mochi/`）、`MochiTests`（`MochiTests/`），bundle ID 前缀 `com.zen`
- **测试**：Swift Testing，禁止新增 XCTest
- **依赖**：禁止第三方框架（需先询问）；避免 UIKit/AppKit
- **提交格式**：`type(scope): description`，主分支 `main`；未经要求不提交、不推送
- **Skills**：`swiftui-pro`（写/审查 SwiftUI）、`swift-testing-pro`（测试），位于 `.claude/skills/`

## 架构索引

```text
Views → ViewModels(@Observable, @MainActor) → Services → Models
```

分层、数据边界、并发、目录约定见 `guidelines/architecture.md`；SwiftUI 项目约定见 `guidelines/swiftui-conventions.md`；测试策略见 `guidelines/testing.md`。

## 文档同步边界

`project.yml` 或脚本变化 → 同步 `guidelines/commands.md` 与本文件速查；新增/删除 guideline → 保持本文件 @import 一致。

## 原则遵守

@import guidelines/core.md
@import guidelines/architecture.md
@import guidelines/swiftui-conventions.md
@import guidelines/testing.md
@import guidelines/commands.md
@import guidelines/git-workflow.md
