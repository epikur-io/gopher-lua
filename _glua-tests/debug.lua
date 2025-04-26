
local function test_debughooks()
    local debug = require("debug")

    local function test_call(a, b)
        return a + b
    end

    local counter_c = 0
    local counter_l = 0
    local counter_r = 0

    local function hook(why)
        if why == "call" then
            counter_c = counter_c + 1
        elseif why == "line" then
            counter_l = counter_l + 1            
        elseif why == "return" then
            counter_r = counter_r + 1
        end
        -- print("hook reached: ", why)
        -- print("source =", debug.getinfo(2, "S").short_src)
        -- print("linedefined =", debug.getinfo(2, "S").linedefined)
        -- print("lastlinedefined =", debug.getinfo(2, "S").lastlinedefined)
        -- print("function =", debug.getinfo(2, "n").name)
        -- print("nparams =", debug.getinfo(2, "u").nparams)
        -- print("----------------------------------")
    end -- hook

    debug.sethook(hook, "clr", 0)

    for i = 1, 10 do
        test_call(i, i-1)
    end -- for

    -- expect debug hook to be called 10 times
    assert(counter_c == 10, string.format("counter_c: %s", tostring(counter_c)))
    assert(counter_l == 33, string.format("counter_l: %s", tostring(counter_l)))
    assert(counter_r == 10, string.format("counter_r: %s", tostring(counter_r)))
end

test_debughooks()
