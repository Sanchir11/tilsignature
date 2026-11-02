# Email signature media site

A tiny static site for hosting a signature GIF or a page that links to a video. Open this folder in Cursor.

## Add your media

- Small GIF: copy it to `media/signature.gif`.
- Small MP4: copy it to `media/signature.mp4`.
- Large media (such as 220 MB): do **not** put it in this Git repository or Vercel deployment. Upload the original file to Vercel Blob (or another object storage/CDN), then paste its public URL into `hostedMediaUrl` near the bottom of `index.html`. Leave the file quality unchanged.

The page displays a GIF as animation, or an MP4 with playback controls. Email clients generally do not play embedded MP4 in signatures; for a video, use a linked preview image. Animated GIF support also varies by email client.

## GitHub and Vercel

1. Create an **empty new GitHub repository** for this project (do not reuse an unrelated repository).
2. In Cursor, open this `signature-media-site` folder.
3. In Cursor's terminal, run:

   ```sh
   git add index.html README.md media/.gitkeep
   git commit -m "Set up signature media site"
   git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
   git push -u origin main
   ```

4. In Vercel, choose **Add New → Project**, import that GitHub repository, and deploy. No build command is needed for this plain HTML site.
5. Each later GitHub push to `main` triggers a Vercel deployment. For hosted media, update the URL in `index.html` and push that change.

Replace `YOUR-USERNAME` and `YOUR-REPOSITORY` with the values shown by GitHub. Keep large GIF/MP4 files out of Git history: GitHub blocks ordinary Git objects above 100 MiB, so a 220 MB file cannot be pushed normally. Vercel currently lists a 100 MB static source upload limit on Hobby and 1 GB on Pro; the file exceeds Hobby's limit, and putting it in Git still exceeds GitHub's ordinary file limit. Vercel Blob supports multipart uploads and recommends them for files larger than 100 MB. Check your account's current storage and bandwidth pricing before uploading.

## Use in an email signature

After deployment, use the public media URL. For an animated GIF, a simple signature snippet is:

```html
<img src="https://YOUR-PROJECT.vercel.app/media/signature.gif" alt="Your name" width="320" style="display:block;border:0;height:auto;">
```

If the media is in Blob, replace the `src` value with its public Blob URL. For an MP4, make a small still preview image and link that image to the MP4 URL; the email recipient can click to watch. The site URL itself is a preview page and is not the image URL to use in an email signature.

## Preview locally

Open `index.html` in a browser. A local GIF or MP4 will display when present under `media/`.
# tilsignature
