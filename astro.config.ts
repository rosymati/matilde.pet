import sitemap from '@astrojs/sitemap';
import { defineConfig, fontProviders, svgoOptimizer } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
	site: 'https://rosymati.com',
	integrations: [sitemap()],
	markdown: {
		shikiConfig: {
			theme: 'css-variables',
		},
	},
	fonts: [
		{
			provider: fontProviders.fontsource(),
			name: 'DM Sans',
			cssVariable: '--dm-sans',
			weights: ['400 500 600 700'],
		},
		{
			provider: fontProviders.fontsource(),
			name: ' Instrument Serif ',
			cssVariable: '--instrument',
			weights: ['400 500 600 700'],
		},
	],
	vite: {
		plugins: [tailwindcss()],
	},
	experimental: {
		svgOptimizer: svgoOptimizer({ multipass: true }),
	},
});
