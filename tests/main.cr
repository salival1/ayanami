require "../ayanami/ayanami.cr"
irc = Ayanami::Client.new("irc.ircd-hybrid.org", "rei", realname: "test bot", port: 6697, ssl: true)
irc.connect()