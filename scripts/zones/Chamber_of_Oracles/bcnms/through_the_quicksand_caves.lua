-----------------------------------
-- Area: Chamber of Oracles
-- Name: Zilart Mission 6
-- !pos -221 -24 19 206
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBcnmRegister(player, instance)
end

function onBcnmEnter(player, instance)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(ZILART) ~= tpz.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 and player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES then
        player:completeMission(ZILART, tpz.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
        player:addMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_CHAMBER_OF_ORACLES)
    end
end
