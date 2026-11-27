-- Shared app settings (hero list edits). Already applied to Supabase project EclipseForcePrime.
create table if not exists public.settings (id text primary key, data jsonb not null, updated_at timestamptz not null default now());
alter table public.settings enable row level security;
create policy settings_read on public.settings for select to anon, authenticated using (true);
create policy settings_write on public.settings for all to authenticated using (public.is_admin()) with check (public.is_admin());
alter publication supabase_realtime add table public.settings;
