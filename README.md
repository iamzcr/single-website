# single_website

多个单页官网项目的集合仓库。每个子目录对应一个独立项目的静态官网（落地页），均可单独构建、部署到静态服务器。

## 项目列表

| 子目录 | 官网主题 | 对应产品 |
| --- | --- | --- |
| `call-my-ai-worker/` | 「一次提问，多个 AI 同时回答」浏览器扩展官网 | [iamzcr/call-my-ai-worker](https://github.com/iamzcr/call-my-ai-worker)（MV3 扩展源码） |

### call-my-ai-worker

「一次提问，多个 AI 同时回答」浏览器扩展的静态官网。该扩展基于 Manifest V3 开发，在同页内以 iframe 平铺各个 AI 网页，支持勾选多个站点、输入一个问题后一键分发，各站点同时生成回答。

官网核心内容：

- **一次提问，多站并行**：勾选多个站点，输入一个问题一键分发，各站点同时回答。
- **国内 / 海外分组**：内置多个国内 / 海外主流站点，侧边栏分组展示，默认勾选常用国内站点。
- **上下文保持**：追问自动延续各站点对话；改选站点时仍选中的站点上下文不丢。
- **单站点刷新重问**：每个站点可单独刷新并重新提交当前问题，不影响其他站点。
- **一键停止回答**：点击停止即可让各站点停止生成并中断跟踪，不关闭扩展窗口。
- **站点可配置**：选项页可增删站点、调整选择器，支持选择器测试与配置导入导出。

## 技术栈

- [Vue 3](https://vuejs.org/)（Composition API + `<script setup>`）
- [Vite](https://vitejs.dev/)
- [Vue Router 4](https://router.vuejs.org/)（hash 模式，便于任意子路径部署）
- [Naive UI](https://www.naiveui.com/)

## 快速开始

```bash
cd call-my-ai-worker

# 安装依赖
npm install

# 启动开发服务
npm run dev

# 生产构建
npm run build

# 本地预览构建产物
npm run preview
```

## 部署

### 手动部署

每个项目构建产物输出到自身 `dist/` 目录。`vite.config.js` 设置了 `base: './'`，产物可直接部署到任意静态服务器或子路径（如 GitHub Pages、Nginx 等），无需额外配置；路由使用 hash 模式，刷新/直接访问任意路径均不会 404。

### SCP 推送脚本

仓库根目录提供 `deploy.ps1`，用于构建 + 推送单个项目的 `dist/` 到服务器指定路径。

```powershell
# 默认推送 call-my-ai-worker 到 <Target>:/data/single-website/call-my-ai-worker
.\deploy.ps1 -Target root@1.2.3.4

# 指定其他项目 / 跳过构建 / 自定义端口与远程根路径
.\deploy.ps1 -Target root@1.2.3.4 -ProjectPath .\other-site -SkipBuild
.\deploy.ps1 -Target root@1.2.3.4 -Port 2222 -RemoteBase /data/www
```

脚本行为：

1. 校验项目目录存在且包含 `package.json`
2. 默认执行 `npm run build`（`-SkipBuild` 时跳过）
3. 检查 `dist/` 已生成
4. `ssh` 远程 `mkdir -p <RemoteBase>/<ProjectName>` 后清空该目录旧内容
5. `scp -P <Port> -r dist/*` 平铺推送到远程目标目录

采用密码认证，ssh 与 scp 各交互输入一次密码，不硬编码凭据。

## 目录结构

```
single_website/
├── deploy.ps1            # SCP 部署脚本（构建 + 推送 dist）
├── call-my-ai-worker/    # call-my-ai-worker 官网项目
│   ├── index.html        # 入口 HTML
│   ├── vite.config.js    # Vite 配置（base: './'）
│   ├── public/
│   │   ├── icon128.png   # 站点图标
│   │   └── demo/         # 演示截图（轮播用）
│   └── src/
│       ├── main.js       # 应用入口（含滚动显现指令）
│       ├── App.vue       # 根组件
│       ├── assets/       # 静态资源（logo 等）
│       ├── router/       # 路由配置
│       ├── styles/       # 全局样式与 CSS 变量
│       ├── views/        # 页面视图
│       ├── components/   # 页面区块组件
│       └── utils/        # 工具（安装链接分发等）
└── ...
```
