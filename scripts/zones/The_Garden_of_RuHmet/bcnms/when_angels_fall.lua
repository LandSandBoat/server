-----------------------------------
-- Area: The_Garden_of_RuHmet
-- Name: When Angels Fall
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
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
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(COP) ~= xi.mission.id.cop.WHEN_ANGELS_FALL or player:getCharVar("PromathiaStatus") ~= 4) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 0, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid== 32001 then
        if player:getCurrentMission(COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and player:getCharVar("PromathiaStatus") == 4 then
            player:setCharVar("PromathiaStatus", 5)
        end
        player:setPos(420, 0, 445, 192)
    end
end

return battlefield_object
