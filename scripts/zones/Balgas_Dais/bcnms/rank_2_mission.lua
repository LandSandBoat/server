-----------------------------------
-- Area: Balgas Dais
-- Name: Mission Rank 2
-- !pos 299 -123 345 146
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
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

        if
            player:getCurrentMission(xi.mission.log_id.SANDORIA) == xi.mission.id.sandoria.JOURNEY_TO_WINDURST2 or
            player:getCurrentMission(xi.mission.log_id.BASTOK) == xi.mission.id.bastok.THE_EMISSARY_WINDURST2
        then
            player:setLocalVar("battlefieldWin", battlefield:getID())
        end

        if player:hasCompletedMission(player:getNation(), 5) then
            player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 1)
        else
            player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
        end
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
end

return battlefieldObject
