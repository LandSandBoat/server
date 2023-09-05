-----------------------------------
-- custom_util
-----------------------------------
require("modules/module_utils")
require("scripts/globals/npc_util")
-----------------------------------
local m = Module:new("custom_util")

m.rate =
{
    GUARANTEED  = 1000, -- 100%
    VERY_COMMON =  240, --  24%
    COMMON      =  150, --  15%
    UNCOMMON    =  100, --  10%
    RARE        =   50, --   5%
    VERY_RARE   =   10, --   1%
    SUPER_RARE  =    5, -- 0.5%
    ULTRA_RARE  =    1, -- 0.1%
}

-- player, { { rate, item } }, modifier
m.pickItem = function(player, items, mod)
    -- sum weights
    local sum = 0
    for i = 1, #items do
        if mod ~= nil then
            sum = sum + items[i][1][mod]
        else
            sum = sum + items[i][1]
        end
    end

    -- pick weighted result
    local item = items[1]
    local pick = math.random(1, sum)
    sum = 0

    for i = 1, #items do
        if mod ~= nil then
            sum = sum + items[i][1][mod]
        else
            sum = sum + items[i][1]
        end

        if sum >= pick then
            item = items[i]
            break
        end
    end

    return item
end

m.dialogTable = function(player, tbl, npcName, param)
    local prefix = ""

    if npcName and string.len(npcName) > 0 then
        prefix = string.format("%s : ", npcName)
    end

    if #tbl == 1 then
        local result = tbl[1]
        if param then
            result = string.format(tbl[1], param[1], param[2], param[3], param[4])
        end
            player:PrintToPlayer(prefix .. result, xi.msg.channel.NS_SAY)
        return
    end

    for i = 1, #tbl do
        local result = tbl[i]
        local delay  = (i - 1) * 1000

        if param then
            result = string.format(tbl[i], param[1], param[2], param[3], param[4])
        end

        if tbl[i]:sub(1, 1) == " " then
            -- Paragraph continue
            player:timer(delay, function(playerArg)
                playerArg:PrintToPlayer(result, xi.msg.channel.NS_SAY)
            end)
        else
            -- New paragraph
            player:timer(delay, function(playerArg)
                playerArg:PrintToPlayer(prefix .. result, xi.msg.channel.NS_SAY)
            end)
        end
    end
end

m.duplicateOverride = function(entity, event, func)
    if not entity then
        return
    end

    local origEvent = event .. "Orig"

    if entity[origEvent] == nil and entity[event] then
        entity[origEvent] = entity[event]
    end

    local thisenv = getfenv(entity[event])
    local env = { super = entity[origEvent] }

    setmetatable(env, { __index = thisenv })
    setfenv(func, env)

    entity[event] = func
end

return m
