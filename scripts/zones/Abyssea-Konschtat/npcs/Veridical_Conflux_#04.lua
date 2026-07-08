-----------------------------------
-- Area: Abyssea-Konschtat
--  NPC: Veridical Conflux #04
-- Aybssea Teleport NPC
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.conflux.confluxOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.conflux.confluxEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.conflux.confluxEventFinish(player, csid, option, npc)
end

return entity
