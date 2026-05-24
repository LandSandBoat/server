-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Linkshell Concierge
-- !pos 76.260 0.000 9.700 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.linkshellConcierge.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.linkshellConcierge.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.linkshellConcierge.onEventFinish(player, csid, option, npc)
end

return entity
