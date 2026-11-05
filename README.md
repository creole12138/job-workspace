# 求职工作台

投递追踪（列表 / 看板 / 日历）、面试复盘、Offer 对比。数据存在 Supabase，登录后电脑和手机同步，只有本人能读写。

- 网页：GitHub Pages 发布 `index.html`
- 数据库：`supabase/setup.sql` 建表并开启行级权限
- 保活：`.github/workflows/keepalive.yml` 每 3 天访问一次数据库，避免免费项目因 7 天无访问被暂停
