-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Swirling Vortex
-- Entrance to Lufaise Meadows
-- !pos 420.057 0.000 -199.905 103
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/missions")
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasCompletedMission(COP, tpz.mission.id.cop.THE_MOTHERCRYSTALS)) then
        player:startEvent(12)
    else
        player:messageSpecial(ID.text.AN_EMPTY_LIGHT_SWIRLS)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 12 and option == 1) then
        tpz.teleport.to(player, tpz.teleport.id.LUFAISE_VORTEX)
    end

end
