-- Keep OG Storage private and constrain each object to 50 MB.
update storage.buckets
set public = false,
    file_size_limit = 52428800
where id = 'og-files';

drop policy if exists "OG storage users upload own files within 50MB" on storage.objects;
drop policy if exists "OG storage users upload own files" on storage.objects;
drop policy if exists "OG storage users read own files" on storage.objects;
drop policy if exists "OG storage users update own files" on storage.objects;
drop policy if exists "OG storage users delete own files" on storage.objects;

create policy "OG storage users upload own files"
on storage.objects
for insert
to authenticated
with check (
  bucket_id = 'og-files'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

create policy "OG storage users read own files"
on storage.objects
for select
to authenticated
using (
  bucket_id = 'og-files'
  and owner_id = (select auth.uid())::text
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

create policy "OG storage users update own files"
on storage.objects
for update
to authenticated
using (
  bucket_id = 'og-files'
  and owner_id = (select auth.uid())::text
  and (storage.foldername(name))[1] = (select auth.uid())::text
)
with check (
  bucket_id = 'og-files'
  and owner_id = (select auth.uid())::text
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

create policy "OG storage users delete own files"
on storage.objects
for delete
to authenticated
using (
  bucket_id = 'og-files'
  and owner_id = (select auth.uid())::text
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

drop function if exists private.og_storage_has_capacity(bigint);
