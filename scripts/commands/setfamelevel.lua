-----------------------------------
-- func: setfamelevel
-- desc: Sets fame level on a target player
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 3,
    parameters = 'iis'
}

local function error(player, msg)
    if msg == nil then
        msg = '!setfamelevel <fame_zone 0-15> <level 1-9> <player> (Omit level and target to show zone numbers)'
    end

    player:printToPlayer(msg)
end

commandObj.onTrigger = function(player, famezone, level, target)
    -- validate target
    local targ

    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found or not a valid player!', target))
            return
        end
    end

    local fameZoneNames = {}
    for name, value in pairs(xi.fameArea) do
        fameZoneNames[value] = name
    end

    if famezone == nil then
        error(player)
        return
    elseif famezone < 0 or famezone > 15 then
        error(player, 'You must provide a fame zone from 0 to 15.')
        return
    end

    -- validate level
    if level == nil then
        player:printToPlayer(string.format('Fame Zone %s: %s - No other parameters requested.', famezone, fameZoneNames[famezone]))
        return
    elseif level < 0 or level > 9 then
        error(player, 'You must provide a fame level from 1 to 9.')
        return
    end

    local fameBaseValues = { 0, 50, 125, 225, 325, 425, 488, 550, 613 }
    local fameMultiplier = xi.settings.map.FAME_MULTIPLIER

    if level > 6 and (famezone >= 6 and famezone <= 14) then -- Abyssea fame caps at level 6
        level = 6
        error(player, 'Abyssea fame capped at level 6. Setting to level 6.')
    end

    targ:setFame(famezone, fameBaseValues[level] / fameMultiplier)
    player:printToPlayer(string.format('Set %s\'s fame for fame area %i (%s) to %i (Level %i).', targ:getName(), famezone, fameZoneNames[famezone], fameBaseValues[level], level))
end

return commandObj
