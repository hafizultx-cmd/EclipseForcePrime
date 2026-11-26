# Eclipse Force Prime OS

Team operating system for the Eclipse Force Prime Mobile Legends squad: schedule and calendar, results, player and hero statistics, titles, and shareable result cards.

- **Hosting:** Vercel project `eclipseforceprime` (static site, no build step).
- **Data:** Supabase project `EclipseForcePrime` (tables `matches`, `roster`, `admins`).
- **Access:** everyone can read. Only emails listed in `public.admins` can write, after signing in with a confirmed Supabase account.

## Deploy
Push to the `main` branch of `EclipseForcePrime` on GitHub. Vercel deploys `index.html` as-is.

## Admin setup
1. Run `supabase/migrations/001_core_schema.sql` (already applied).
2. `insert into public.admins (email) values ('your@email');`
3. Open the site, press **Admin sign-in**, choose **Create account** with that email, confirm the email, then sign in.

## Notes
- The Supabase URL and publishable key in `index.html` are public by design. Security comes from the row-level-security policies.
- Screenshot scanning needs Claude and is only available in the Claude artifact version, not on this site.
- The hero list is not verified against the live game. Any hero name can be typed.
