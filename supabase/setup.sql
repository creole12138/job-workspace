-- 在 Supabase 的 SQL Editor 里运行一次
create table if not exists public.items (
  id text primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  kind text not null,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.items enable row level security;
drop policy if exists "own rows" on public.items;
create policy "own rows" on public.items
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
