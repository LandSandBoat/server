-----------------------------------
-- Area: Lufaise Meadows
--  NPC: Swirling Vortex
--  Entrance to Valkurm Dunes
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(100)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 100 and option == 1) then
        tpz.teleport.to(player, tpz.teleport.id.VALKURM_VORTEX)
    end

end
