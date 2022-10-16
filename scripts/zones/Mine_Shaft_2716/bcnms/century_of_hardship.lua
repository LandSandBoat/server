-----------------------------------
-- A Century of Hardship
-- Mine Shaft #2716 mission battlefield
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(xi.mission.log_id.COP) ~= xi.mission.id.cop.THREE_PATHS or player:getMissionStatus(xi.mission.log_id.COP, xi.mission.status.COP.LOUVERANCE) ~= 8) and 1 or 0

        player:setLocalVar('battlefieldWin', battlefield:getID())

        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:addExp(1000)
    end
end

return battlefieldObject
