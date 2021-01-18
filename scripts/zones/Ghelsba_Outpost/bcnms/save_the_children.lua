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
        local arg8 = (player:hasCompletedMission(tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.SAVE_THE_CHILDREN)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
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

return battlefield_object
