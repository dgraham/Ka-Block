// Create filter predicate function for blocked domains.
function filter(domains) {
  var all = domains.map(function(domain) {
    return '\\.' + domain.replace(/[.]/, '\\.')
  }).join('|')

  var re = new RegExp('(' + all + ')$', 'i')
  return re.test.bind(re)
}

// Predicate returns true for blocked domains.
var blocked = filter(window.domains)

// Respond to approval requests from start script.
safari.application.addEventListener('message', function(event) {
  if (event.name === 'canLoad') {
    var host = new URL(event.message).hostname
    event.message = blocked(host) ? 'block' : 'allow'
  }
}, true)
