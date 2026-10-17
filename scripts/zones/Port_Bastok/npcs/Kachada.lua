-----------------------------------
-- Area: Port Bastok
--  NPC: Kachada
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.worldPass.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.worldPass.onEventFinish(player, csid, option, npc)
end

return entity
