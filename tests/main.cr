require "../ayanami/ayanami.cr"
irc = Ayanami::Client.new("irc.ircd-hybrid.org", "rei", realname: "test bot")
irc.connect()