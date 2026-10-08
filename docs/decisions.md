# 决策与背景摘要

这份文件整理自产品设计阶段的对话，是 [产品规格](product-specs/radio/001-ai-radio.md) 与 [设计规格](design-specs/radio/001-ai-radio.md) 的索引与补充。冲突时以这份为准，并请指出来让我同步更新文档。

整理日期：2026-10-08

## 原始想法（我的话）

我想做一个 AI 原生的音乐电台，核心诉求：

- 有一个主理人每天给我推荐音乐。我现在的音乐千篇一律、比较乏味，希望音乐可以根据当天的天气、我最近喜欢听的歌曲等随机自动推荐，也不要告诉我歌单。
- 主理人像电台一样，在推荐过程中介绍歌曲的故事和背景，有一种娓娓道来的故事感。故事和声音前期突出人声、音乐是背景，一个简短的介绍：介绍这个故事、为什么要推荐，然后开始正常播放。
- 形态上，可能是灵动岛模式，也可能是吸顶或侧边。
- 对话风格是科幻的，类似《复仇者联盟》里钢铁侠的管家。

## 已确认的决策

| 问题 | 决定 |
| --- | --- |
| 「AI 原声」的含义 | AI 原生：把 LLM 集成为产品功能（选曲理由、故事口播）。**不含** AI 生成音乐 |
| 平台 | macOS，目标机型带刘海 |
| 音源 | Apple Music、QQ 音乐；网络爬取只作兜底 |
| QQ 音乐播放路径 | 路径 B：通过非官方接口取播放链接，由本 App 自带播放器播放（ducking 完全可控）；接口失效时降级到 Apple Music |
| 歌单可见性 | 可以看到歌名和历史记录，但不展示队列、不生成歌单、不可导出；历史阅后即焚 |
| 主理人 | 温柔女声，名称 **Lyra（天琴）**，想换名随时可改 |
| 口播频率 | 默认每首歌都讲，可配置（每 2–3 首、仅新歌、关闭） |
| 大模型与 TTS | 云端，由我自行配置；口播脚本默认用 GLM-5.3-Flash |
| 实现方式（MVP） | 程序编排整条流程，LLM 只写口播脚本 |
| 故事资料 | 允许联网检索（MusicBrainz、维基百科等），检索只发送曲名与艺人 |
| 项目性质 | 个人项目 |
| 悬浮岛形态 | 从刘海处展开的自绘 NSPanel（macOS 没有系统级灵动岛）；菜单栏面板作常驻入口；吸顶条与侧边悬浮窗放 P1 |

## 与文档的差异（以这里为准）

- 产品规格 5.4 写了「口播尽量在前奏内收尾」。技术方案里没有实现前奏分析：口播与歌曲同时开始，音乐先压低、口播结束后渐强，靠把口播控制在 30 秒以内来避免音乐被压低太久。如果需要前奏对齐，要再加前奏时长的判断。

## 对话中查证过的事实（2026-10 的状态，可能已变化）

- **GLM-5.3-Flash**：智谱 2026 年 8 月发布，模型 ID `glm-5.3-flash`，支持 1M 上下文与 Function Calling。对话接口为 `POST https://open.bigmodel.cn/api/paas/v4/chat/completions`，Bearer 鉴权，支持流式。**思考模式不能关闭**，只能用 `reasoning_effort`（low / high / max，默认 max）调强度；口播这类短文本先试 low。同系列有更快的 `glm-5.3-flashx`。它只输出文本，不能发声。官方文档：https://docs.bigmodel.cn/api-reference/模型-api/对话补全
- **QQ 音乐**：官方没有第三方开放接口。社区库 qqmusic-api-python（仓库 L-1124/QQMusicApi，`pip install qqmusic-api-python`，Python 3.10+，完全异步，GPL-3.0）。用法：`client.search.search_by_type` 搜索，`client.song.get_song_urls` 取链接（需要 CDN 节点 + 登录凭证），扫码登录用 `QRCodeLoginSession`。文档：https://l-1124.github.io/QQMusicApi/
- **社区 MCP server**：mcp-music-server（支持 QQ/网易云/酷狗，QQ 需扫码登录）与 mcp-qqmusic-test-server（仅搜索，测试用）。它们底层都依赖上面这个非官方库。
- **Apple Music**：歌曲受 DRM 保护，不能走自己的音频引擎。压低音乐的候选做法：MusicKit 播放器自身音量、AppleScript 控制 Music.app 的 sound volume、调系统输出音量（口播也变小，最差）、先口播后放歌（兜底，必定可行）。均未验证。

## 部署目标

最低 **macOS 15**（`project.yml`）。原始方案写的 macOS 14，已按项目设置统一为 15。

## 待验证（阶段 0）

1. QQ 音乐：取到播放链接并在本地播放器中稳定播放；会员歌曲的登录凭证如何续期。→ `artifacts/stage0/01_qq_probe.py`
2. Apple Music：压低音乐的做法。→ `artifacts/stage0/02_ducking_music_app.sh`
3. 口播模型：GLM-5.3-Flash 与 FlashX 的首字延迟和总耗时，以及格式与事实约束。→ `artifacts/stage0/03_llm_latency.py`
4. 故事资料：联网检索的覆盖率。→ `artifacts/stage0/04_story_research.py`
5. TTS：试听几家云端中文语音，选定温柔女声。（还没有脚本，选定服务后补）

## 沟通偏好

- 回复用中文，简洁，先结论后细节。
- 文档要「能直接用」：给我可运行的脚本、可落地的方案，不要泛泛而谈。
- 涉及版权与非官方接口的地方要明确标出风险，由我自己决定。

> 阶段 0 验证脚本位于本地 `artifacts/stage0/`（不入库，克隆后不存在）；验证结论应整理回本文件或设计规格。
