
local function test_debughooks()
    local debug = require("debug")

    local function test_call(a, b)
        return a + b
    end

    local counter = 0

    local function hook(why)
        counter = counter + 1
        -- print("hook reached: ", why)
        -- print("function =", debug.getinfo(2, "n").name)
    end -- hook

    debug.sethook(hook, "r", 0)
    debug.sethook()

    for i = 1, 10 do
        test_call(i, i-1)
    end -- for

    -- expect debug hook to be called 10 times
    assert(counter == 10)
end

test_debughooks()
