# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Mochi 是个人项目：常驻菜单栏的 AI 音乐电台。女声主理人 Lyra 按天气、时段和近期听歌偏好选歌，每首歌前用一小段故事口播，音乐压低为背景。目前只有模板代码，处于阶段 0（技术验证）。最低 macOS 15、Swift 6、App Sandbox、ad-hoc 签名（无需开发者账号）。

## 先读什么

@docs/decisions.md

细节按需再读，不要一次全载入：[产品规格](docs/product-specs/radio/001-ai-radio.md)、[设计规格](docs/design-specs/radio/001-ai-radio.md)。阶段 0 验证脚本在本地 `artifacts/stage0/`（不入库）。

> 规范细节全部位于 `guidelines/`（本文件底部 @import）。本文件只保留速查和 agent 行为指令，细则一律引用既有规范，禁止在此复写。

## 命令速查

```bash
xcodegen generate                                    # 改 project.yml / 增删源文件后必须执行
scripts/check.sh                                     # 门禁：generate → build → test
xcodebuild -scheme Mochi -destination 'platform=macOS' build
xcodebuild -scheme Mochi -destination 'platform=macOS' test -only-testing:MochiTests/MochiTests/example
```

命令权威清单唯一来源：`guidelines/commands.md`。

## 产品约束

- **选曲由程序完成，LLM 只写口播脚本**（MVP 不做 Agent 式工具调用）。
- **故事只能来自检索到的资料**；没有可靠资料时降级为 `reason_only`，不得编造。
- **口播是附加品，任何一环失败都不能让音乐停下**，逐级降级，最差只放歌。
- 口播预生成：歌曲 N 开始播放时就为 N+1 生成并缓存。
- LLM 与 TTS 分别抽象为 `LLMProvider` / `TTSProvider`，由用户自行配置；密钥与凭证只放 macOS 钥匙串。

## 当前阶段

阶段 0（技术验证）。**未过「关口 0」（压低音乐的做法已定、口播耗时可接受）前，不写阶段 1 的功能代码，只做验证。**

## 工作方式

- 用中文回复，简洁，先结论后细节。
- 实现与 `docs/` 冲突，或发现 docs 有错时，先指出来，等用户确认后再改代码并同步更新 docs。
- 不提交：API 密钥、`~/.config/mochi/` 下的凭证、`qrcode*` 文件（已写入 `.gitignore`）。
- QQ 音乐走非官方接口，仅限个人自用、不分发；接口变化时报告现象，不要硬凑绕过。
- 不克隆任何影视角色或真实演员的声音；Lyra 是原创人设。

## 门禁运行策略

每次改动后只运行与改动相关的检查：只改视图跑 `build`，改逻辑跑相关 `-only-testing`。全量 `scripts/check.sh` 必须先征得用户同意。

## 快速参考

- **项目配置**：`project.yml` 是唯一来源，`Mochi.xcodeproj` 为生成物、已 gitignore，禁止手改
- **Target**：`Mochi`（源码 `Mochi/`）、`MochiTests`（`MochiTests/`），bundle ID 前缀 `com.zen`
- **测试**：Swift Testing，禁止新增 XCTest
- **依赖**：禁止第三方框架（需先询问）；避免 UIKit/AppKit
- **提交格式**：`type(scope): description`，主分支 `main`；未经要求不提交、不推送
- **文档**：产品规格 → 设计规格 → 实施任务，位于 `docs/`（入口 `docs/README.md`），同一功能三份文档共用编号；新功能先写/更新规格再实现
- **视觉**：`guidelines/design-system.md` 是视觉唯一来源；改规范先改它，再改 `MochiTheme`，视图中禁止硬编码颜色/字号/间距
- **Skills**：`swiftui-pro`（写/审查 SwiftUI）、`swift-testing-pro`（测试），位于 `.claude/skills/`

## 架构索引

```text
Views → ViewModels(@Observable, @MainActor) → Services → Models
```

分层、数据边界、并发、目录约定见 `guidelines/architecture.md`；SwiftUI 项目约定见 `guidelines/swiftui-conventions.md`；测试策略见 `guidelines/testing.md`；文档目录、命名与流程见 `guidelines/docs-structure.md`；**做任何 UI（悬浮岛、面板、图标、动效）前先读 `guidelines/design-system.md`**，视觉数值只取自 `MochiTheme`。

## 文档同步边界

`project.yml` 或脚本变化 → 同步 `guidelines/commands.md` 与本文件速查；新增/删除 guideline → 保持本文件 @import 一致；新增文档领域 → 同步对应 `docs/*/README.md` 的领域索引。

## 原则遵守

@import guidelines/core.md
@import guidelines/architecture.md
@import guidelines/swiftui-conventions.md
@import guidelines/testing.md
@import guidelines/commands.md
@import guidelines/git-workflow.md
@import guidelines/docs-structure.md
