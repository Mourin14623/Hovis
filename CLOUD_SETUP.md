# Hovis Cloud — Setup Guide

## Current cloud architecture
- Supabase Auth (email sign-in)
- Supabase Postgres metadata table: `hovis_movies`
- Private Supabase Storage bucket: `Movies`
- Per-user storage folders and RLS rules
- GitHub Pages front-end

## 1. Get the public Supabase project values
In Supabase dashboard: **Project Settings → API** (or API Keys).
Copy the **Project URL** and the **publishable/anon key** only. Never put a service-role key in a website.

## 2. Storage bucket
Storage → Files → Movies → Settings. Make the bucket **Private**. Free plan upload size limit may be 50 MB; videos above the limit will not upload unless plan/limits change.

## 3. Database policies
Open SQL Editor, paste and run `supabase-cloud.sql`.

## 4. Auth URL settings
Authentication → URL Configuration:
- Site URL: `https://mourin14623.github.io/Hovis/`
- Add Redirect URL: `https://mourin14623.github.io/Hovis/**`

## 5. OAuth note
Google sign-in is optional; configure Google provider in Supabase Auth after the Google OAuth consent/client setup. Email sign-in can be used first.

## Security
Only publish the Supabase publishable/anon key in frontend config. Keep service-role keys and database passwords secret. Private storage is protected by RLS policies in the SQL file.

## Limitations
Cloud video storage is not yet connected to the main Hovis UI. This setup prepares the database and access controls; the next code stage adds sign-in, uploads, library sync, and signed playback URLs.
