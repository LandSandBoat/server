-----------------------------------
-- func: goto
-- desc: Goes to the target player.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'si'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!goto <player> (forceZone)')
end

commandObj.onTrigger = function(player, target, forceZone)
    -- validate target
    if not target then
        error(player, 'You must enter a player name.')
        return
    end

    -- validate forceZone
    if forceZone then
        if forceZone ~= 0 and forceZone ~= 1 then
            error(player, 'If provided, forceZone must be 1 (true) or 0 (false).')
            return
        end
    else
        forceZone = 1
    end

    local targ = GetPlayerByName(target)
    -- if we found this player, they're on the same zone server
    -- if they're in mog house, goto them instead of setPos
    if targ and not targ:isInMogHouse() then
        player:setPos(targ:getXPos(), targ:getYPos(), targ:getZPos(), targ:getRotPos(), forceZone == 1 and targ:getZoneID() or nil)
    elseif not player:gotoPlayer(target) then
        error(player, string.format('Player named: %s not found!', target))
    end
end

return commandObj
