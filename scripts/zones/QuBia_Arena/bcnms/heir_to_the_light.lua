-----------------------------------
-- Heir to the Light
-- Qu'Bia Arena mission battlefield
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
local ID = require("scripts/zones/QuBia_Arena/IDs")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("phaseChange", 1)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(SANDORIA) ~= xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if
        csid == 32001 and
        player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and
        player:getMissionStatus(player:getNation()) == 3
    then
        player:setMissionStatus(player:getNation(), 4)
    end
end

return battlefield_object
