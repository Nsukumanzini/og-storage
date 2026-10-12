# OG Storage

OG Storage is a private cloud-storage website with Supabase authentication and file storage.

## Main features

- Images, Videos, Documents, and Music categories
- Private previews and secure downloads
- Required custom file name before every upload
- 50 MB maximum storage per user
- Email verification returns users to the sign-in screen
- Production domain: https://cloud.ogtechnologies.co.za

## Run the project

1. Install Node.js 22 or newer.
2. Copy `.env.example` to `.env.local`.
3. Add the Supabase project URL and publishable key.
4. Run `npm install`.
5. Run `npm run dev`.

## Build

Run `npm run build` to create a production build.

The website is connected to the Vercel project named `og-storage` and uses the `og-files` bucket in the OG Vibes Supabase project.
