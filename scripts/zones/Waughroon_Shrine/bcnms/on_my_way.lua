-----------------------------------
-- On My Way
-- Waughroon Shrine mission battlefield
-- !pos -345 104 -260 144
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()

        if player:getCurrentMission(xi.mission.log_id.BASTOK) == xi.mission.id.bastok.ON_MY_WAY then
            player:setLocalVar("battlefieldWin", battlefield:getID())
        end

        local arg8 = player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.ON_MY_WAY) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
end

return battlefield_object
