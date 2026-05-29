import sitemap from '@astrojs/sitemap';
import { defineConfig, fontProviders, svgoOptimizer } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
	site: 'https://matilde.pet',
	integrations: [sitemap()],
	fonts: [
		{
			provider: fontProviders.fontsource(),
			name: 'Fredoka',
			cssVariable: '--fredoka',
			weights: ['500 600 700'],
		},
	],
	vite: {
		plugins: [tailwindcss()],
	},
	experimental: {
		svgOptimizer: svgoOptimizer({ multipass: true }),
	},
});
