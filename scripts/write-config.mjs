import { writeFileSync } from 'node:fs'

const config = {
  url: process.env.SUPABASE_URL || '',
  key: process.env.SUPABASE_ANON_KEY || '',
}

if (!config.url || !config.key) {
  console.warn('SUPABASE_URL or SUPABASE_ANON_KEY is missing; the dashboard will show "Not configured".')
}

writeFileSync('config.js', `window.EFP_SUPABASE=${JSON.stringify(config)};\n`)
console.log('Wrote config.js')
