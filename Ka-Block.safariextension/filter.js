// Detect third-level domains.
function third(domain) {
  return domain.split('.').length > 2
}

// Create filter predicate function for blocked domains.
function filter(domains) {
  const all = domains.map(function(domain) {
    const escaped = domain.replace(/[.]/g, '\\.')
    return third(domain) ? escaped : '\\.' + escaped
  }).join('|')

  const re = new RegExp('(' + all + ')$', 'i')
  return re.test.bind(re)
}

// Predicate returns true for blocked domains.
const blocked = filter(window.domains)

// Respond to approval requests from start script.
safari.application.addEventListener('message', function(event) {
  if (event.name === 'canLoad') {
    const host = new URL(event.message).hostname
    event.message = blocked(host) ? 'block' : 'allow'
  }
}, true)
