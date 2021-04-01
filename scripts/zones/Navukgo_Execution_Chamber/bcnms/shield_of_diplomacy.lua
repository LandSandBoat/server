-----------------------------------
-- Area: Navukgo Execution Chamber
-- BCNM: TOAU-22 Shield of Diplomacy
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
local ID = require("scripts/zones/Navukgo_Execution_Chamber/IDs")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldInitialise = function(battlefield)

    local karababa  = battlefield:insertEntity(8, true, true)
    karababa:setSpawn(360.937, -116.5, 376.937, 0)
    karababa:spawn()
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.SHIELD_OF_DIPLOMACY)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 and player:getCurrentMission(TOAU) == xi.mission.id.toau.SHIELD_OF_DIPLOMACY then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.SHIELD_OF_DIPLOMACY)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.SOCIAL_GRACES)
        player:setCharVar("AhtUrganStatus", 0)
    end
end

return battlefield_object
