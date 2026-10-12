-- Keep large owner uploads isolated from the standard 50 MB user bucket.
insert into storage.buckets (id, name, public, file_size_limit)
values ('og-owner-files', 'og-owner-files', false, 5368709120)
on conflict (id) do update
set public = false,
    file_size_limit = excluded.file_size_limit;

drop policy if exists "OG owner uploads private large files" on storage.objects;
drop policy if exists "OG owner reads private large files" on storage.objects;
drop policy if exists "OG owner updates private large files" on storage.objects;
drop policy if exists "OG owner deletes private large files" on storage.objects;

create policy "OG owner uploads private large files"
on storage.objects for insert to authenticated
with check (
  bucket_id = 'og-owner-files'
  and lower((select auth.jwt()->>'email')) = 'nsukumanziniii@gmail.com'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

create policy "OG owner reads private large files"
on storage.objects for select to authenticated
using (
  bucket_id = 'og-owner-files'
  and lower((select auth.jwt()->>'email')) = 'nsukumanziniii@gmail.com'
  and owner_id = (select auth.uid())::text
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

create policy "OG owner updates private large files"
on storage.objects for update to authenticated
using (
  bucket_id = 'og-owner-files'
  and lower((select auth.jwt()->>'email')) = 'nsukumanziniii@gmail.com'
  and owner_id = (select auth.uid())::text
  and (storage.foldername(name))[1] = (select auth.uid())::text
)
with check (
  bucket_id = 'og-owner-files'
  and lower((select auth.jwt()->>'email')) = 'nsukumanziniii@gmail.com'
  and owner_id = (select auth.uid())::text
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

create policy "OG owner deletes private large files"
on storage.objects for delete to authenticated
using (
  bucket_id = 'og-owner-files'
  and lower((select auth.jwt()->>'email')) = 'nsukumanziniii@gmail.com'
  and owner_id = (select auth.uid())::text
  and (storage.foldername(name))[1] = (select auth.uid())::text
);
