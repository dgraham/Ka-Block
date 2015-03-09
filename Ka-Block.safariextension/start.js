// Filter all external resource requests.
document.addEventListener('beforeload', function(event) {
  // Resolve relative URLs.
  var url = new URL(event.url, window.location.href)

  // Skip about:blank, data:image, etc.
  if (!url.origin || url.origin === 'null') {
    return
  }

  // Allow same origin resources.
  if (window.location.origin === url.origin) {
    return
  }

  // Check with global page for approval.
  var approval = safari.self.tab.canLoad(event, url.href)
  if (approval === 'block') {
    event.preventDefault()
  }
}, true)
