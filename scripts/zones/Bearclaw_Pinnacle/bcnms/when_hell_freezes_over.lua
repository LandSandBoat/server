-----------------------------------
-- When Hell Freezes Over
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("loot", 1)
    battlefield:setLocalVar("lootSpawned", 1)
    battlefield:setLocalVar("adds", 2)
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    if player:hasKeyItem(xi.ki.ZEPHYR_FAN) then
        player:delKeyItem(xi.ki.ZEPHYR_FAN)
    end
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:addExp(3000)
    end
end

return battlefieldObject
