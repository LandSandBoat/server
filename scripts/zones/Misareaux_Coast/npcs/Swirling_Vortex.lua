-----------------------------------
-- Area: Misareaux Coast
--  NPC: Swirling Vortex
--  Entrance to Qufim Island
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(554)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 554 and option == 1) then
        tpz.teleport.to(player, tpz.teleport.id.QUFIM_VORTEX)
    end

end
