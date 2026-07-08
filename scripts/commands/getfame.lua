-----------------------------------
-- func: getfame
-- desc: Gets fame level of a target player
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 3,
    parameters = 'si'
}

local function error(player, msg)
    if msg == nil then
        msg = '!getfame [player] <fame_zone 0-15>'
    end

    player:printToPlayer(msg)
end

commandObj.onTrigger = function(player, target, famezone)
    -- validate target
    local targ = nil

    if target == nil then
        if player:getCursorTarget() == nil then
            targ = player
        else
            if player:getCursorTarget():isPC() then
                targ = player:getCursorTarget()
            else
                error(player, 'You must target a player or specify a name.')
                return
            end
        end
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

    -- Validate famezone
    if famezone == nil then
        player:printToPlayer(string.format('Fame Report for player: %s', targ:getName()), xi.msg.channel.SYSTEM_3)
        for i = 0, 15 do
            player:printToPlayer(string.format('Area %s (%s): %s (Level: %s)', i, fameZoneNames[i], player:getFame(i), player:getFameLevel(i)), xi.msg.channel.SYSTEM_3)
        end

        return
    elseif famezone < 0 or famezone > 15 then
        error(player, 'Fame zone must be a value from 0 to 15, or omit for complete list.')
        return
    end

    local fameBaseValues = { 0, 50, 125, 225, 325, 425, 488, 550, 613 }
    local fame = player:getFame(famezone)
    local level = player:getFameLevel(famezone)

    if level < 9 then
        player:printToPlayer(string.format('%s\'s reputation in fame area %i (%s) is %i (Level %i). Next level at %i (%i points to go).', targ:getName(), famezone, fameZoneNames[famezone], fame, level, fameBaseValues[level + 1], fameBaseValues[level + 1]-fame), xi.msg.channel.SYSTEM_3)
    else
        player:printToPlayer(string.format('%s\'s reputation in fame area %i (%s) is %i (Level %i).', targ:getName(), famezone, fameZoneNames[famezone], fame, level), xi.msg.channel.SYSTEM_3)
    end
end

return commandObj
