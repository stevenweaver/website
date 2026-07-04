import { redirect } from '@sveltejs/kit';

// The Review Brah analysis moved from Tutorials to Articles.
// Forward the old URL so existing links keep working.
export const prerender = true;

export function load() {
	redirect(308, '/articles/reviewbrah/');
}
