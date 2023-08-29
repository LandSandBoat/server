-----------------------------------
-- Area: Navukgo Execution Chamber
-- BCNM: Omens
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    -- local mobOffset = (battlefield:getArea() - 1) * 7  -- Offset to spawn correct mob depending on battlefieldNumber
    local trackVar = 'entered_'.. player:getName()
    if battlefield:getLocalVar(trackVar) ~= 1 then
        battlefield:setLocalVar(trackVar, 1)
        battlefield:setLocalVar('num_entrants', battlefield:getLocalVar('num_entrants') + 1)
    end
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()

        player:setLocalVar('battlefieldWin', battlefield:getID())

        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar('[cs]bit'), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option, npc)
end

battlefieldObject.onEventFinish = function(player, csid, option, npc)
end

return battlefieldObject
