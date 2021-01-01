-----------------------------------
-- Area: Qufim Island
--  NPC: Swirling Vortex
-- Entrance to Qufim Island
-- !pos -436.000 -13.499 340.117 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/teleports")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasCompletedMission(tpz.mission.log_id.COP, tpz.mission.id.cop.THE_MOTHERCRYSTALS) then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.AN_EMPTY_LIGHT_SWIRLS)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 300 and option == 1 then
        tpz.teleport.to(player, tpz.teleport.id.MISAREAUX_VORTEX)
    end
end
