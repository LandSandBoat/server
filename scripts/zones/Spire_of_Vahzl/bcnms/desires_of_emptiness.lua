-----------------------------------
-- Desires of Emptiness
-- Spire of Vahzl mission battlefield
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(COP) ~= tpz.mission.id.cop.DESIRES_OF_EMPTINESS or player:getCharVar("PromathiaStatus") ~= 8) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 0, battlefield:getLocalVar("[cs]bit"), 0, arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if player:getCurrentMission(COP) == tpz.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 8 then
            player:setCharVar("PromathiaStatus", 9)
        end
        player:addExp(1500)
        player:addTitle(tpz.title.FROZEN_DEAD_BODY)
        player:setPos(-340.00, -100.25, 140.00, 64, 111) -- {R}
    end
end
