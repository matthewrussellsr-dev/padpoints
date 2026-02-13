# PadPoints 🛢️

**Personal map + business card site for North Slope operations.**  
Live at: [padpoints.com](https://padpoints.com)

---

## What This Is

- **`/`** — Interactive image map of the North Slope. Drop pins anywhere. Search them by name, tag, or category. Click a pin to see details + images.
- **`/card.html`** — Your business card: contact info, bio, photo, gallery.
- **`/admin.html`** — Password-protected dashboard to add/edit/delete pins, change colors, add images.

All pin data lives in **Supabase** (free database). No code editing needed to manage content.

---

## Setup Guide (One Time)

### Step 1: Supabase Database

1. Go to [supabase.com](https://supabase.com) → Sign up free
2. Click **New Project** → name it `padpoints` → set a database password → Create
3. Wait ~2 minutes for it to spin up
4. Go to **SQL Editor** (left sidebar) → **New Query**
5. Open `supabase-setup.sql` from this repo → paste it all → click **Run**
6. Go to **Settings → API** → copy:
   - **Project URL** (looks like `https://abcdefgh.supabase.co`)
   - **anon public** key (long string starting with `eyJ...`)

### Step 2: Configure the Site

Open `js/config.js` and fill in:

```javascript
supabase: {
  url:     'https://YOUR_PROJECT_ID.supabase.co',  // ← paste here
  anonKey: 'eyJ...',                                // ← paste here
},
adminPassword: 'your-strong-password-here',         // ← change this!

card: {
  name:     'John Smith',
  title:    'Field Engineer · Arctic Oil Co.',
  location: 'North Slope, Alaska',
  bio:      'Your bio here...',
  contacts: [
    { icon: '📞', label: 'PHONE', value: '+1 (907) 555-0000', href: 'tel:+19075550000' },
    { icon: '✉',  label: 'EMAIL', value: 'john@email.com',    href: 'mailto:john@email.com' },
  ],
},
```

### Step 3: Add Your Map Image

1. Get a screenshot or export of the North Slope roads map you want to use
2. Save it as `assets/map.jpg` (or `.png` — update the path in `config.js`)
3. Higher resolution = better. PNG is sharper, JPG is smaller file size.

### Step 4: GitHub Repo

```bash
# In your terminal, from the padpoints folder:
git init
git add .
git commit -m "Initial PadPoints setup"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/padpoints.git
git push -u origin main
```

Then in GitHub:
- Go to repo **Settings → Pages**
- Source: **Deploy from branch** → `main` → `/ (root)` → Save
- ✅ **Make sure your repo is PRIVATE** (Settings → General → Change visibility)

### Step 5: Connect Your Domain

In your domain registrar's DNS settings, add:

| Type  | Name | Value                     |
|-------|------|---------------------------|
| A     | @    | 185.199.108.153           |
| A     | @    | 185.199.109.153           |
| A     | @    | 185.199.110.153           |
| A     | @    | 185.199.111.153           |
| CNAME | www  | YOUR_USERNAME.github.io   |

Then in GitHub repo **Settings → Pages → Custom domain** → type `padpoints.com` → Save  
Check **Enforce HTTPS**

Takes 10–30 minutes to go live the first time.

---

## Adding Pins (Daily Use)

1. Go to `padpoints.com/admin.html`
2. Enter your password
3. Click **ENABLE PLACE MODE** → click anywhere on the map
4. Fill in the title, description, tags, color, etc.
5. Click **SAVE PIN**

The pin appears on the live map instantly (real-time sync).

---

## Editing Your Business Card

Open `js/config.js` and edit the `card:` section.

To add a **profile photo**: save it as `assets/profile.jpg`  
To add **gallery images**: save them in `assets/images/` and list paths in `card.gallery`

After editing, push to GitHub:
```bash
git add .
git commit -m "Update contact info"
git push
```

---

## Search How It Works

The search bar filters pins in real-time. Each additional word narrows results further.

- Searching `pad` → shows all pads
- Searching `pad prudhoe` → shows only pads tagged with "prudhoe"
- Click tag pills below the search bar to quick-filter

Add searchable tags to each pin in the admin panel (comma separated).

---

## Folder Structure

```
padpoints/
├── index.html          ← map page
├── card.html           ← business card
├── admin.html          ← admin panel (password protected)
├── css/
│   ├── style.css       ← main styles
│   └── admin.css       ← admin panel styles
├── js/
│   ├── config.js       ← YOUR SETTINGS (edit this)
│   ├── app.js          ← map + search logic
│   ├── admin.js        ← admin panel logic
│   └── card.js         ← business card logic
├── assets/
│   ├── map.jpg         ← YOUR MAP IMAGE (add this)
│   ├── profile.jpg     ← YOUR PHOTO (optional)
│   ├── images/         ← gallery / pin images
│   └── map-placeholder.svg  ← shown until map.jpg is added
├── supabase-setup.sql  ← run this once in Supabase
└── README.md
```

---

## Updating the Site After Changes

```bash
git add .
git commit -m "Describe what you changed"
git push
```

GitHub auto-deploys in ~30 seconds.

---

## Optional: Full Privacy with Cloudflare Access

If you want the **entire site** locked (not just admin), use Cloudflare Access (free):
1. Transfer your domain to Cloudflare (or just use Cloudflare nameservers)
2. Go to Cloudflare Zero Trust → Access → Applications → Add application
3. Select the domain → Set allowed emails/login methods
4. Now anyone visiting padpoints.com must log in first

---

## Need Help?

- Supabase docs: [supabase.com/docs](https://supabase.com/docs)
- GitHub Pages docs: [docs.github.com/pages](https://docs.github.com/en/pages)
- DNS setup: check your registrar's help docs (GoDaddy, Namecheap, etc.)
