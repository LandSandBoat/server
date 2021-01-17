-----------------------------------
-- Area: Throne Room
-- Name: Bastok Mission 9-2
-- !pos -111 -6 0 165
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldInitialise(battlefield)
    battlefield:setLocalVar("phaseChange", 1)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(BASTOK) ~= tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    player:setCharVar("MissionStatus", 2) -- This should be MissionStatus..But all battlefields of same var need updated.
end
