-----------------------------------
-- Area: The Celestial Nexus
-- Name: The Celestial Nexus (ZM16)
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
require("scripts/globals/titles")
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
        local arg8 = (player:hasCompletedMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_CELESTIAL_NEXUS)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        if player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THE_CELESTIAL_NEXUS then
            player:completeMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_CELESTIAL_NEXUS)
            player:addMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.AWAKENING)
            player:addTitle(tpz.title.BURIER_OF_THE_ILLUSION)
            player:setCharVar("ZilartStatus", 0)
        end
        player:setPos(0, -18, 137, 64, 251) -- Hall of the Gods
    end
end

return battlefield_object
