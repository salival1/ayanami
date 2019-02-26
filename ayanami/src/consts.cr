module Ayanami
    Version = "0.0.2"
    RealName = "Ayanami v#{Ayanami::Version} https://gitgud.io/salival/ayanami"
    module Strings
        PRIVMSG = "PRIVMSG %s :%s"
        NOTICE = "NOTICE %s :%s"
        JOIN = "JOIN %s"
        PART = "PART %s %s"
        INVITE = "INVITE %s %s"
        KICK = "KICK %s %s :%s"
        MODE = "MODE %s %s"
        NICK = "NICK %s"
        USER = "USER %s 0 0 :%s"
        PONG = "PONG :%s"
    end
end