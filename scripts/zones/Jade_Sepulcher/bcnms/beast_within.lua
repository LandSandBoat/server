-----------------------------------
-- Area: Jade Sepulcher
-- BCNM: The Beast Within BLU 75 Cap
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/bcnm")
require("scripts/globals/quests")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    player:addStatusEffect(xi.effect.SJ_RESTRICTION, 0, 0, 600) -- Inflict SJ Restriction
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()

        if
            player:getMainJob() == xi.job.BLU and
            player:getMainLvl() >= 66
        then
            player:setLocalVar('battlefieldWin', battlefield:getID())
        end

        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 4)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
end

return battlefieldObject
