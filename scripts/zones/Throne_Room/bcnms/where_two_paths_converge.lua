-----------------------------------
-- Area: Throne Room
-- Name: Bastok Mission 9-2
-- !pos -111 -6 0 165
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("phaseChange", 1)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()

        if
            player:getCurrentMission(xi.mission.log_id.BASTOK) == xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE
        then
            player:setLocalVar("battlefieldWin", battlefield:getID())
        end

        local arg8 = (player:getCurrentMission(xi.mission.log_id.BASTOK) ~= xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    player:setMissionStatus(player:getNation(), 2) -- This should be missionStatus..But all battlefields of same var need updated.
end

return battlefieldObject
