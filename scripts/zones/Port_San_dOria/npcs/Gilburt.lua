-----------------------------------
-- Area: Port San d'Oria
--  NPC: Gilburt
-- Type: Abyssea Service NPC
-- !pos 8.27 -4 -65 232
-----------------------------------
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.traverserNPCOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.traverserNPCOnUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.traverserNPCOnEventFinish(player, csid, option, npc)
end

return entity
