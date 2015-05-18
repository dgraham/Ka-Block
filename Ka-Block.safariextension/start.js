// Remember domain filter results.
const cache = new Map()

// Check with global page for approval.
function blocked(event, url) {
  var result = cache.get(url.hostname)
  if (result === undefined) {
    result = safari.self.tab.canLoad(event, url.href) === 'block'
    cache.set(url.hostname, result)
  }
  return result
}

// Filter all external resource requests.
document.addEventListener('beforeload', function(event) {
  // Resolve relative URLs.
  const url = new URL(event.url, window.location.href)

  // Skip about:blank, data:image, etc.
  if (!url.origin || url.origin === 'null') {
    return
  }

  // Allow same origin resources.
  if (window.location.origin === url.origin) {
    return
  }

  if (blocked(event, url)) {
    event.preventDefault()
  }
}, true)
