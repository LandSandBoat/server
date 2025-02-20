-----------------------------------
-- Area: Lufaise Meadows
--  NPC: Swirling Vortex
--  Entrance to Valkurm Dunes
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(100)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 100 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.VALKURM_VORTEX)
    end
end

return entity
