# KA-BLOCK!

A Safari browser extension that blocks an artisanal selection of advertising
domains.

![Ka-Block](/Ka-Block.safariextension/Icon.png)

## State of the art

The most popular ad blocking extensions take a no holds barred, nuke them from
orbit approach. The goal is not only to never see an ad on a web page, but to never
see the sad, empty space left behind by the ad that used to be.

While this is highly effective, there is a heavy price to pay. The list of rules
filtering out advertisements in these extensions weighs in at over 1 MB. It
includes partial domain matches, URL fragments, highly specific HTML element
identifiers that were found on at least one web page at some point in the last
decade. They may or may not exist on any page today, and there's no way to
verify their existence.

These filtering rules also contain a whitelist of *allowable* ads. If your
corporation pays their corporation enough money, the ad blocker allows your
ads through so the visitor may view them. Not only did you pay for the ad,
you paid a third-party for it to actually be viewed by a human.

That's a nice billboard you have there. It would be a shame if something
happened to it.

This list must be refreshed periodically in our browsers. The extension makes
a network connection, downloads the list again, and stores it in memory. Some
ad blocker extensions take this opportunity to store unique information about
us on their servers. Sites visited, links clicked, type of browser, and
operating system information can all be stored on their server to build a
profile of each user.

The irony of an extension designed to protect a person's privacy, violating
it within seconds of installing is delicious.

## There must be a better way

This extension's goals are modest.

- Block *most* ads and trackers.
- Never contact a server.
- Never slow down a page.

Some ads will get through this filter, and that's ok. We already have
extensions that block every ad that's ever appeared on the web with a
completionist zeal that must be admired. Provided we accept the tradeoffs
described above, those blockers work great.

This ad filtering code makes *zero* network connections. The only way for the
list of blocked domains to be updated is to release a new version of the
extension itself.

The filtering is implemented in less than 100 lines of JavaScript. Each time
an image or JavaScript file is requested by a page, Safari checks with this
extension to determine if it's allowed to download it. If the resource is
served by a blocked domain, it's rejected and the browser doesn't download
it at all.

## Installation

Ka-Block! can be installed from the [Safari Extensions Gallery][gallery].

Alternatively, you can download the [latest Ka-Block.safariextz][latest]
file and double-click to install.

## Updating the domain list

If there's a pesky ad-serving domain that's getting through the filter, open
a pull request with the domain and a site or two on which its ads appear. We'll
add it to the [blocked domains list](/Ka-Block.safariextension/blockerList.json)
and release a new version of the extension to include it.

## License

Ka-Block! is released under the terms of the MIT license. Check the LICENSE
file for details.

<3

[latest]: https://github.com/dgraham/Ka-Block/releases/latest
[gallery]: https://extensions.apple.com/details/?id=com.negativecode.safari.ka-block-UYW4V22L7E
