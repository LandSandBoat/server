-----------------------------------
-- Heir to the Light
-- Qu'Bia Arena mission battlefield
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar('phaseChange', 1)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(xi.mission.log_id.SANDORIA) ~= xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT) and 1 or 0

        if player:getCurrentMission(xi.mission.log_id.SANDORIA) == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT then
            player:setLocalVar('battlefieldWin', battlefield:getID())
        end

        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar('[cs]bit'), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option, npc)
end

battlefieldObject.onEventFinish = function(player, csid, option, npc)
    if
        csid == 32001 and
        player:getCurrentMission(xi.mission.log_id.SANDORIA) == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and
        player:getMissionStatus(player:getNation()) == 3
    then
        player:setMissionStatus(player:getNation(), 4)
    end
end

return battlefieldObject
