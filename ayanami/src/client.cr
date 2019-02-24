require "socket"
# require "./consts.cr"
module Ayanami
    class Client
        def initialize(server : String, nick : String, **kwargs)
            @server = server
            @port = kwargs["port"]? || 6667
            @connected = false
            @nick = nick
            @realname = kwargs["realname"]? || "Ayanami v#{Ayanami::Version} https://gitgud.io/salival/ayanami"
            @sock = TCPSocket.new()
        end

        def send(message : String|Array(String))
            if message.is_a?(Array(String))
                message.each{|x| send(x)} 
            else 
                @sock.send("#{message}\n")
                puts "<< #{message}"
            end
        end

        def privmsg(target : String, message : String) send("PRIVMSG #{target} :#{message}") end

        def notice(target : String, message : String) send("NOTICE #{target} :#{message}") end #TODO: find way to combine this and privmsg()

        def join(channel : String) send("JOIN #{channel}") end

        def part(channel : String, reason : String) send("PART #{channel} :#{reason}") end
            
        def invite(user : String, channel : String) send("INVITE #{user} #{channel}") end
        
        def kick(channel : String, user : String, reason : String) send("KICK #{user} :#{reason}") end

        def mode(target : String, flags : String) send("MODE #{target} #{flags}") end
        
        def connect()
            @sock.connect(@server, @port, 25)
            @sock.send("NICK #{@nick}\n")
            @sock.send("USER #{@nick} 0 0 :#{@realname}\n")
            while ((resp=@sock.gets("\n", 512)))
                puts ">> #{resp}"
                if (resp[0] == 'P')
                    send("PONG #{resp[5..-1]}")
                else
                    resp = resp.split()
                end
            end
        end
    end
end