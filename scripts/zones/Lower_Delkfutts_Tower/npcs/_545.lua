-----------------------------------
-- Area: Lower Delkfutt's Tower
--  NPC: Cermet Door
-- Notes: Involved in Missions: THREE_PATHS
-----------------------------------
local ID = require("scripts/zones/Lower_Delkfutts_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and
        player:getCharVar("COP_Tenzen_s_Path") == 6 and
        player:hasKeyItem(tpz.ki.DELKFUTT_RECOGNITION_DEVICE) and
        npcUtil.popFromQM(player, npc, ID.mob.DISASTER_IDOL, {hide = 0})
    then
        -- no further action
    elseif
        player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and
        player:getCharVar("COP_Tenzen_s_Path") == 7 and
        player:hasKeyItem(tpz.ki.DELKFUTT_RECOGNITION_DEVICE)
    then
        player:startEvent(25)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 25 then
        player:setCharVar("COP_Tenzen_s_Path", 8)
    end
end
