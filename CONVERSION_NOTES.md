# VuePress to SvelteKit Conversion

This website has been successfully converted from VuePress to SvelteKit!

## What Changed

### Framework
- **From**: VuePress 0.14.11
- **To**: SvelteKit 2.x with Svelte 5

### Components Converted
- ✅ `fractal.vue` → `Fractal.svelte` (Canvas-based fractal rendering)
- ✅ `phylotree.vue` → `Phylotree.svelte` (Observable notebook integration)
- ✅ Theme components (Navbar, Sidebar, Layout)

### Styling
- ✅ Converted from Stylus to CSS
- ✅ Maintained original VuePress aesthetic
- ✅ Responsive design preserved

### Routing Structure
All pages have been migrated with the same URL structure:
- `/` - Home page with bio and fractal
- `/publications` - Publications list
- `/misc/quotations` - Quotes
- `/tutorials/reviewbrah` - Review Brah ratings
- `/tutorials/kraken` - Kraken tutorial
- `/av/*` - Books, Audio, and Visual content

## New Development Commands

```bash
# Development server
yarn dev

# Build for production
yarn build

# Preview production build
yarn preview
```

## Architecture

- **Markdown Processing**: Using mdsvex for .md files
- **Components**: Located in `src/lib/components/`
- **Routes**: File-based routing in `src/routes/`
- **Static Assets**: Served from `static/`

## Key Features Retained

- Navigation bar with external links (GitHub, Twitter)
- Sidebar navigation
- Markdown content with embedded Svelte components
- Observable notebook integration for phylotree visualization
- Canvas-based fractal background

## Old Files

The original VuePress configuration and theme files have been moved to `.vuepress-old/` for reference.

## Development

The site runs on http://localhost:5173/ in development mode and builds successfully with no errors (only minor accessibility warnings for iframe titles).

## Deployment

### Automatic Deployment Script

A deployment script has been created to build and deploy the static site to NearlyFreeSpeech.Net:

```bash
# Deploy the site
yarn deploy
# or
./deploy.sh
```

The script will:
1. Build the site using `yarn build`
2. Create a static site in the `build/` directory
3. Use `rsync` to deploy to `maximumsteve_stevenweaver@ssh.nyc1.nearlyfreespeech.net:/home/public/`

### Manual Deployment

If you prefer to deploy manually:

```bash
# Build the site
yarn build

# Deploy with rsync
rsync -avz --delete build/ maximumsteve_stevenweaver@ssh.nyc1.nearlyfreespeech.net:/home/public/
```

### Configuration

The static site adapter is configured in `svelte.config.js` to output to the `build/` directory. All pages are pre-rendered at build time for optimal performance.
