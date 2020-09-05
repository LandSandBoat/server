-----------------------------------
-- Area: Quicksand Caves
--  NPC: ??? (qm4)
-- Involved in Mission: Bastok 8.1 "The Chains That Bind Us"
-- !pos
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Quicksand_Caves/IDs")
-----------------------------------

function onTrigger(player, npc)
    local missionStatus = player:getCharVar("MissionStatus")
    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_CHAINS_THAT_BIND_US) and (missionStatus == 2) then
        player:startEvent(10)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onTrade(player, npc, trade)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10) then
        player:setCharVar("MissionStatus", 3)
    end
end
