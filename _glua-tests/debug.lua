
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
        -- print("name =", debug.getinfo(2, "Slunf").name)
        -- print("what =", debug.getinfo(2, "Slunf").what)
        -- print("source =", debug.getinfo(2, "Slunf").source)
        -- print("counter_c =", debug.getlocal(2, 3))
        -- print("currentline =", debug.getinfo(2, "Slunf").currentline)
        -- print("linedefined =", debug.getinfo(2, "Slunf").linedefined)
        -- print("lastlinedefined =", debug.getinfo(2, "Slunf").lastlinedefined)
        -- print("function =", debug.getinfo(2, "Slunf").name)
        -- print("nups =", debug.getinfo(2, "Slunf").nups)
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
