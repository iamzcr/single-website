const CHROME_WEB_STORE_URL = ''
const FIREFOX_ADDONS_URL = ''
const EDGE_ADDONS_URL =
  'https://microsoftedge.microsoft.com/addons/detail/lolahlclbhfoobkilinkhlkmdipagoib'

function detectBrowser() {
  const ua = navigator.userAgent.toLowerCase()
  if (ua.includes('firefox')) return 'firefox'
  if (ua.includes('edg')) return 'edge'
  if (ua.includes('chrome')) return 'chrome'
  return ''
}

export function installUrl() {
  const browser = detectBrowser()
  if (browser === 'chrome' && CHROME_WEB_STORE_URL) return CHROME_WEB_STORE_URL
  if (browser === 'firefox' && FIREFOX_ADDONS_URL) return FIREFOX_ADDONS_URL
  return EDGE_ADDONS_URL
}
