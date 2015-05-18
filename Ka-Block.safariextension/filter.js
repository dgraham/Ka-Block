// Match literal dots in domain names.
function escape(domain) {
  return domain.replace(/[.]/g, '\\.')
}

// Create filter predicate function for blocked domains.
function filter(domains) {
  const all = domains.map(escape).join('|')
  const re = new RegExp('(?:^|\\.)(?:' + all + ')$', 'i')
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
