-----------------------------------
-- func: setmod
-- desc: Sets the specified modifier to the specified value on the cursor target or player
-----------------------------------
cmdprops =
{
    permission = 1,
    parameters = "sis"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setmod <modifier> <amount> (optional target)")
end

function onTrigger(player, modifier, amount, target)
    if not modifier or not amount then
        error(player, "Must specify modifier and amount. ")
        return
    end

    local modID = tonumber(modifier) or xi.mod[string.upper(modifier)]
    if not modID then
        error(player, "No valid modifier found. ")
        return
    end

    if target then
        target = GetPlayerByName(target)
    else
        target = player:getCursorTarget()
    end

    if not target or target:isNPC() then
        error(player, "No valid target found. place cursor on a non-npc object or specify a player name. ")
        return
    end

    local oldmod = target:getMod(modID)
    target:setMod(modID, amount)
    player:PrintToPlayer(string.format("Target name: %s (Target ID: %i) | Old %s modifier value: %i | New %s modifier value: %i", target:getName(), target:getID(), modifier, oldmod, modifier, amount))
end
