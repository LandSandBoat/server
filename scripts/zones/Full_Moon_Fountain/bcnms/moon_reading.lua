-----------------------------------
-- Area: Full Moon Mountain
-- Name: Windurst Mission 9-2 Moon Reading
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("phaseChange", 1)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(WINDURST) ~= tpz.mission.id.windurst.MOON_READING) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if
        csid == 32001 and
        player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.MOON_READING and
        player:getCharVar("MissionStatus") == 2
    then
        player:setCharVar("MissionStatus", 3)
    end
end

return battlefield_object
