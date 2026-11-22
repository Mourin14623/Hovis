-- HOVIS CLOUD DATABASE SETUP
-- Paste into Supabase SQL Editor and run.
create table if not exists public.hovis_movies (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  storage_path text,
  video_url text,
  poster_url text,
  favorite boolean not null default false,
  watched boolean not null default false,
  progress_seconds numeric not null default 0,
  duration_seconds numeric not null default 0,
  created_at timestamptz not null default now()
);
alter table public.hovis_movies enable row level security;
drop policy if exists "Users manage their own Hovis movies" on public.hovis_movies;
create policy "Users manage their own Hovis movies"
on public.hovis_movies for all to authenticated
using (owner_id = auth.uid()) with check (owner_id = auth.uid());

-- Create a private bucket named Movies in Storage first.
-- Storage paths should be: <user-uuid>/<movie-filename>
drop policy if exists "Users upload to own Hovis folder" on storage.objects;
create policy "Users upload to own Hovis folder"
on storage.objects for insert to authenticated
with check (bucket_id = 'Movies' and (storage.foldername(name))[1] = auth.uid()::text);
drop policy if exists "Users read own Hovis files" on storage.objects;
create policy "Users read own Hovis files"
on storage.objects for select to authenticated
using (bucket_id = 'Movies' and (storage.foldername(name))[1] = auth.uid()::text);
drop policy if exists "Users update own Hovis files" on storage.objects;
create policy "Users update own Hovis files"
on storage.objects for update to authenticated
using (bucket_id = 'Movies' and (storage.foldername(name))[1] = auth.uid()::text)
with check (bucket_id = 'Movies' and (storage.foldername(name))[1] = auth.uid()::text);
drop policy if exists "Users delete own Hovis files" on storage.objects;
create policy "Users delete own Hovis files"
on storage.objects for delete to authenticated
using (bucket_id = 'Movies' and (storage.foldername(name))[1] = auth.uid()::text);
