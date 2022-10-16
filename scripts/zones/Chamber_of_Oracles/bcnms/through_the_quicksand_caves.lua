-----------------------------------
-- Area: Chamber of Oracles
-- Name: Zilart Mission 6
-- !pos -221 -24 19 206
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

        if player:getCurrentMission(xi.mission.log_id.ZILART) == xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES then
            player:setLocalVar("battlefieldWin", battlefield:getID())
        end

        local arg8 = (player:getCurrentMission(xi.mission.log_id.ZILART) ~= xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
end

return battlefieldObject
