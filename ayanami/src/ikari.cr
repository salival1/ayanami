module Ayanami
    alias EventHolster = Hash(String, String|Int32|Bool|Hash(String, String|Bool)) 
    alias HookFunc = Proc(EventHolster, Nil)
    class Ikari
        def initialize()
            @storage = Hash(String, Array(HookFunc)).new
        end

        def register(event : String, ptr : HookFunc)
            @storage[event] ||= Array(HookFunc).new

            printf("hooked %s to event %s\n", ptr, event)

            @storage[event].push(ptr)
        end

        def fire(event : String, args = EventHolster.new) # cold and ugly. Please PR better method
            @storage[event].each do |hook|
                hook.call(args)
            end if @storage.has_key?(event)
        end
    end
end