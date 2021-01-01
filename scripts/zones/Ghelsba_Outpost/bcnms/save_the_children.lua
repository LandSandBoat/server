-----------------------------------
-- Save the Children
-- Ghelsba Outpost mission battlefield
-- !pos -162 -11 78 140
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
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
        local arg8 = (player:hasCompletedMission(tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.SAVE_THE_CHILDREN)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if
        csid == 32001 and
        option == 0 and
        player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.SAVE_THE_CHILDREN and
        player:getCharVar("MissionStatus") == 2
    then
        npcUtil.giveKeyItem(player, tpz.ki.ORCISH_HUT_KEY)
        player:setTitle(tpz.title.FODDERCHIEF_FLAYER)
        player:setCharVar("MissionStatus", 3)
    end
end
