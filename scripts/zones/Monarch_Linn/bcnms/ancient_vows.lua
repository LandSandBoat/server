-----------------------------------
-- Area: Monarch Linn
-- Name: Ancient Vows
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(COP) ~= tpz.mission.id.cop.ANCIENT_VOWS or player:getCharVar("PromathiaStatus") ~= 2) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 0, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:addExp(1000)
        player:addTitle(tpz.title.TAVNAZIAN_TRAVELER)
        if player:getCurrentMission(COP) == tpz.mission.id.cop.ANCIENT_VOWS and player:getCharVar("PromathiaStatus") == 2 then
            player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.ANCIENT_VOWS)
            player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.THE_CALL_OF_THE_WYRMKING)
            player:setCharVar("VowsDone", 1)
            player:setCharVar("PromathiaStatus", 0)
            player:setPos(694, -5.5, -619, 74, 107) -- South Gustaberg
        end
    end
end

return battlefield_object
