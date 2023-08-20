-----------------------------------
-- Area: Lufaise Meadows
--  NPC: Swirling Vortex
--  Entrance to Valkurm Dunes
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(100)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 100 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.VALKURM_VORTEX)
    end
end

return entity
