require "../ayanami/ayanami.cr"

def on_connect(ctx : Ayanami::EventHolster) puts("online.") end

def on_line(ctx : Ayanami::EventHolster) puts(ctx["line"]) end

def on_privmsg(ctx : Ayanami::EventHolster) 
    puts("new message from #{ctx["nick"]} (#{ctx["host"]}) to #{ctx["target"]}: #{ctx["message"]}")
end

def on_kick(ctx : Ayanami::EventHolster)
    puts("#{ctx["user"]} was kicked from #{ctx["channel"]} by #{ctx["nick"]} [#{ctx["reason"]}]")
end

irc = Ayanami::Client.new("irc.ircd-hybrid.org", "rei", realname: "test bot", port: 6697, ssl: true)

irc.register("welcome", ->on_connect(Ayanami::EventHolster))
irc.register("line", ->on_line(Ayanami::EventHolster))
irc.register("privmsg", ->on_privmsg(Ayanami::EventHolster))
irc.register("kick", ->on_kick(Ayanami::EventHolster))

irc.connect()