module Ayanami
    module Utils
        def split_host(mask : String)
            mask = mask[1..-1] if mask[0] == ':'
            imask, host = mask.split("@")
            nick, ident = imask.split("!")
            Ayanami::User.new(nick, ident, host)
        end
    end
    extend Utils
end