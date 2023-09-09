-----------------------------------
-- func: setmobmod
-- desc: Sets the specified mob modifier to the specified value on the cursor target mob
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 3,
    parameters = 'sis'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!setmod <modifier> <amount>')
end

commandObj.onTrigger = function(player, modifier, amount)
    if not modifier or not amount then
        error(player, 'Must specify modifier and amount. ')
        return
    end

    local modID = tonumber(modifier) or xi.mobMod[string.upper(modifier)]
    if not modID then
        error(player, 'No valid modifier found. ')
        return
    end

    local target = player:getCursorTarget()

    if not target or target:isNPC() then
        error(player, 'No valid target found. Place cursor on a mob. ')
        return
    end

    if not target:isMob() then
        error(player, 'No valid target found. Place cursor on a mob. ')
        return
    end

    local oldmod = target:getMobMod(modID)
    target:setMobMod(modID, amount)
    player:PrintToPlayer(string.format('Target name: %s (Target ID: %i) | Old %s modifier value: %i | New %s modifier value: %i', target:getName(), target:getID(), modifier, oldmod, modifier, amount))
end

return commandObj
