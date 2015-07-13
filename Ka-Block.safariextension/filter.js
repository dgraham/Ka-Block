// Match literal dots in domain names.
function escape(domain) {
  return domain.replace(/[.]/g, '\\.')
}

// Get trigger url for block list rule
function ruleURL(rule) {
  return rule.trigger['url-filter']
}

// Create filter predicate function for blocked domains.
function filter(rules) {
  const all = rules.map(ruleURL).map(escape).join('|')
  const re = new RegExp('(?:^|\\.)(?:' + all + ')$', 'i')
  return re.test.bind(re)
}

// Respond to approval requests from start script.
function installCanLoad(rules) {
  const blocked = filter(rules)
  safari.application.addEventListener('message', function(event) {
    if (event.name === 'canLoad') {
      const host = new URL(event.message).hostname
      event.message = blocked(host) ? 'block' : 'allow'
    }
  }, true)
}

function init() {
  const req = new XMLHttpRequest()
  req.responseType = 'json'
  req.onload = function() { installCanLoad(req.response) }
  req.open('GET', 'blockerList.json', true)
  req.send()
}

// Content Blocker polyfill for Safari 8 and under
if (!('onwebkitmouseforcedown' in window)) {
  init()
}
