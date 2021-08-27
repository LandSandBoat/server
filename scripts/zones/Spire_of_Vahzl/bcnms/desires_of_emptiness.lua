-----------------------------------
-- Desires of Emptiness
-- Spire of Vahzl mission battlefield
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
require("scripts/globals/titles")
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
        local arg8 = (player:getCurrentMission(COP) ~= xi.mission.id.cop.DESIRES_OF_EMPTINESS or player:getCharVar("PromathiaStatus") ~= 8) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 0, battlefield:getLocalVar("[cs]bit"), 0, arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        if player:getCurrentMission(COP) == xi.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 8 then
            player:setCharVar("PromathiaStatus", 9)
        end
        player:addExp(1500)
        player:addTitle(xi.title.FROZEN_DEAD_BODY)
        player:setPos(-340.00, -100.25, 140.00, 64, 111) -- {R}
    end
end

return battlefield_object
