-----------------------------------
-- custom_util
-----------------------------------
require("modules/module_utils")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local m = Module:new("custom_util")

m.rate =
{
    VERY_COMMON = 2400,
    COMMON      = 1500,
    UNCOMMON    = 1000,
    RARE        =  500,
    VERY_RARE   =  100,
    SUPER_RARE  =   50,
    ULTRA_RARE  =   10,
}

m.rateTH =
{
    VERY_COMMON = { 2400, 4800, 5600, 6000, 6400, },
    COMMON      = { 1500, 3000, 4000, 4250, 4500, },
    UNCOMMON    = { 1000, 1200, 1500, 1650, 1800, },
    RARE        = {  500,  600,  700,  750,  800, },
    VERY_RARE   = {  100,  150,  200,  225,  250, },
    SUPER_RARE  = {   50,   75,  100,  120,  140, },
    ULTRA_RARE  = {   10,   20,   30,   35,   40, },
}

m.getRateTH = function(mob, rate)
    local level = mob:getTHlevel() + 1

    for k, v in pairs(m.rate) do
        if v == rate then
            return m.rateTH[k][level]
        end
    end

    return rate
end

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
        if param then
            result = string.format(tbl[i], param[1], param[2], param[3], param[4])
        end

        if tbl[i]:sub(1, 1) == " " then
            -- Paragraph continue
            player:PrintToPlayer(result, xi.msg.channel.NS_SAY)
        else
            -- New paragraph
            player:PrintToPlayer(prefix .. result, xi.msg.channel.NS_SAY)
        end
    end

    -- TODO: timer delay
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
