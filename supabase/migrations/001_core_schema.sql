-- Eclipse Force Prime OS: core schema (already applied to Supabase project EclipseForcePrime).
create table public.admins (email text primary key);
alter table public.admins enable row level security;  -- no policies: not reachable from the public API

create table public.matches (id text primary key, data jsonb not null, updated_at timestamptz not null default now());
create table public.roster  (id text primary key, data jsonb not null, updated_at timestamptz not null default now());
alter table public.matches enable row level security;
alter table public.roster  enable row level security;

create or replace function public.is_admin() returns boolean
language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from auth.users u
    join public.admins a on lower(a.email) = lower(u.email)
    where u.id = auth.uid() and u.email_confirmed_at is not null
  );
$$;
revoke execute on function public.is_admin() from public, anon;
grant execute on function public.is_admin() to authenticated;

create policy matches_read  on public.matches for select to anon, authenticated using (true);
create policy roster_read   on public.roster  for select to anon, authenticated using (true);
create policy matches_write on public.matches for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy roster_write  on public.roster  for all to authenticated using (public.is_admin()) with check (public.is_admin());

alter publication supabase_realtime add table public.matches, public.roster;

-- Add an admin (run once, with the email that will sign in):
-- insert into public.admins (email) values ('captain@example.com');
