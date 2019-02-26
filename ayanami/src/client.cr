require "socket"
require "openssl"
module Ayanami
    class Client
        def initialize(server : String, nick : String, **kwargs)
            @server = server
            @port = kwargs["port"]? || 6667
            @connected = false
            @nick = nick
            @ssl = kwargs["ssl"]? || false
            @realname = kwargs["realname"]? || Ayanami::RealName
            @sock = TCPSocket.new(@server, @port)
        end

        def send(message : String|Array(String))
            if message.is_a?(Array(String))
                message.each{|x| send(x)} 
            else 
                @sock << "#{message}\n"
                puts "<< #{message}"
                @sock.flush() # is this really needed? SSL wants it but regular doesnt seem to care 
            end
        end

        def privmsg(target : String, message : String) send(Ayanami::Strings::PRIVMSG % [target, message]) end

        def notice(target : String, message : String) send(Ayanami::Strings::NOTICE % [target, message]) end

        def join(channel : String) send(Ayanami::Strings::JOIN % channel) end

        def part(channel : String, reason : String) send(Ayanami::Strings::PART % [channel, reason]) end
            
        def invite(user : String, channel : String) send(Ayanami::Strings::INVITE % [user, channel]) end
        
        def kick(channel : String, user : String, reason : String) send(Ayanami::Strings::KICK % [channel, user, reason]) end

        def mode(target : String, flags : String) send(Ayanami::Strings::MODE % [target, flags]) end
        
        def nick(nick : String) send(Ayanami::Strings::NICK % nick) end 
        
        def connect()
            if @ssl
                ctx = OpenSSL::SSL::Context::Client.new()
                ctx.verify_mode = OpenSSL::SSL::VerifyMode::NONE # make this configurable
                @sock = OpenSSL::SSL::Socket::Client.new(@sock, ctx)
            end
            nick(@nick)
            send(Ayanami::Strings::USER % [@nick, @realname])
            while ((resp=@sock.gets("\n", 512)))
                puts ">> #{resp}"    
                send(Ayanami::Strings::PONG % resp[6..-1]) if (resp[0] == 'P')
            end
        end
    end
end