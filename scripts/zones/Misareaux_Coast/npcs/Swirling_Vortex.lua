-----------------------------------
-- Area: Misareaux Coast
--  NPC: Swirling Vortex
--  Entrance to Qufim Island
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(554)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 554 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.QUFIM_VORTEX)
    end
end

return entity
