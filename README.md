# 求职工作台

投递追踪、面试复盘、Offer 对比，一页搞定。

- **投递追踪**：卡片 / 看板两种视图，拖动卡片推进阶段；超过 7 天没进展自动提醒
- **圆环漏斗**：投递 → Offer 七个阶段的人数、流失和转化率，点击任意阶段跳到对应投递
- **日历**：笔试、面试标在日期上，时间冲突标红
- **面试复盘**：按轮次记录问题、回答要点、没答好的地方，按公司和题型筛选
- **Offer 对比**：自动算年包和公积金 / CPF，按成长空间、工作强度、匹配度打分

在线体验：<https://creole12138.github.io/job-workspace/>，在登录页点「查看示例」即可用虚构数据体验，无需账号，改动不保存。

## 部署你自己的版本

本仓库的 `index.html` 连接的是作者自己的 Supabase 项目。页面里的 publishable key 本来就可以公开，数据靠数据库的行级权限保护，别人拿到也读不到作者的数据。但如果你 fork 后直接使用，就会连到作者的数据库，而且无法登录（作者已关闭注册）。请按下面步骤换成你自己的 Supabase 项目，全部用免费额度即可。

### 1. Fork 并开启 GitHub Pages

Fork 本仓库，然后进入你的仓库 **Settings → Pages**，Source 选 **Deploy from a branch**，Branch 选 `main`、`/(root)`，保存。几分钟后页面会发布在 `https://<你的用户名>.github.io/job-workspace/`。

### 2. 新建 Supabase 项目并建表

1. 在 <https://supabase.com> 注册并新建项目，区域选离你近的。
2. 打开左侧 **SQL Editor → New query**，粘贴 [`supabase/setup.sql`](supabase/setup.sql) 的全部内容，点 **Run**。看到 `Success. No rows returned` 即成功。

### 3. 换成你的项目地址和密钥

在 Supabase 的 **Project Settings → API Keys** 找到 **Publishable key**（以 `sb_publishable_` 开头），在 **Data API** 找到 **Project URL**（形如 `https://xxxx.supabase.co`）。

然后修改两个文件：

- `index.html`：搜索 `SB_URL` 和 `SB_KEY`，替换成你的 Project URL 和 Publishable key。
- `.github/workflows/keepalive.yml`：把里面的地址和 `apikey` 也换成你的。

> 只用 **Publishable key**。**Secret key 不要放进代码**，它可以绕过所有权限。

### 4. 设置登录

1. **Authentication → URL Configuration**：Site URL 和 Redirect URLs 都填你的 GitHub Pages 地址。
2. **Authentication → Users → Add user → Create new user**：填你的邮箱，勾选 **Auto Confirm User**。
3. **Authentication → Sign In / Providers**：关掉 **Allow new users to sign up**，这样只有你自己能登录。

之后打开页面，输入邮箱、点「发送登录链接」，在邮件里点链接即可登录。

> Supabase 自带的邮件服务每小时只能发很少几封，连续点发送可能被限流，等几分钟再试即可。

### 5. 开启保活任务

Supabase 免费项目连续 7 天无访问会自动暂停。`.github/workflows/keepalive.yml` 每 3 天访问一次数据库来保持活跃。Fork 来的仓库默认不运行定时任务，需要到仓库的 **Actions** 页面点一下启用。

## 文件说明

| 文件 | 作用 |
|---|---|
| `index.html` | 整个网页，单文件，无需构建 |
| `supabase/setup.sql` | 建表，并开启「每个账号只能读写自己的数据」的权限规则 |
| `.github/workflows/keepalive.yml` | 每 3 天访问一次数据库，防止免费项目被暂停 |
