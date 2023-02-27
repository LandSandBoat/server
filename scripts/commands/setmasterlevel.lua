-----------------------------------
-- func: setmasterlevel
-- desc: Sets the master level of player's current job
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setmasterlevel <level> (player?)")
end

function onTrigger(player, level, target)
    local maxMasterLevel = tonumber(xi.settings.main.MAX_MASTER_LEVEL)
    local targetLevel = tonumber(level)
    if not targetLevel or targetLevel < 0 or targetLevel > maxMasterLevel then
        error(player, string.format("Invalid level given. Must be 0-%i", maxMasterLevel))
    end

    local targ
    if target and target ~= "" then
        targ = GetPlayerByName(target)
    else
        targ = player
    end

    if not targ then
        error(player, string.format("Unable to find player '%s'", target))
    end

    targ:setMasterLevel(targetLevel)
    player:PrintToPlayer(string.format("Set %s's master level to %i", targ:getName(), targetLevel))
end
