require "../ayanami/ayanami.cr"

def on_connect(ctx : Ayanami::EventHolster) puts("online.") end

def on_line(ctx : Ayanami::EventHolster) puts(ctx["line"]) end

irc = Ayanami::Client.new("irc.ircd-hybrid.org", "rei", realname: "test bot", port: 6697, ssl: true)

irc.register("welcome", ->on_connect(Ayanami::EventHolster))
irc.register("line", ->on_line(Ayanami::EventHolster))

irc.connect()