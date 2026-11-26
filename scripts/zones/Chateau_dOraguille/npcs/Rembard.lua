-----------------------------------
-- Area: Chateau d'Oraguille (233)
--  NPC: Rembard
-- !pos -6.907 0.000 3.506 233
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.wedding.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.wedding.onEventFinish(player, csid, option, npc)
end

return entity
