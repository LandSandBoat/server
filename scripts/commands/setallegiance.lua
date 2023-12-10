-----------------------------------
-- func: setallegiance
-- desc: Sets the players allegiance.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!setallegiance <allegiance> <player>')
end

commandObj.onTrigger = function(player, allegiance, target)
    -- validate target
    local targ
    local cursorTarget = player:getCursorTarget()

    if target then
        targ = GetPlayerByName(target)
        if not targ then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    elseif cursorTarget and not cursorTarget:isNPC() then
        targ = cursorTarget
    else
        targ = player
    end

    if allegiance == nil or (allegiance < 0 or allegiance > 6) then
        error(player, 'Improper allegiance passed. Valid Values: 0 to 6')
        return
    end

    local toString = { 'Mob', 'Player', 'San d\'Oria', 'Bastok', 'Windurst', 'Wyverns', 'Griffons' }

    player:printToPlayer(string.format('You set %s\'s allegiance to %s', targ:getName(), toString[allegiance + 1]))
    targ:setAllegiance(allegiance)
end

return commandObj
