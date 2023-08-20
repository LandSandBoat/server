-----------------------------------
-- Area: Misareaux Coast
--  NPC: Swirling Vortex
--  Entrance to Qufim Island
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(554)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 554 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.QUFIM_VORTEX)
    end
end

return entity
