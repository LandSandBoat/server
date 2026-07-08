-----------------------------------
-- Area: La Theine Plateau
--  NPC: Cavernous Maw
-- !pos -557.900 0.001 637.846 102
-- Teleports Players to Abyssea - La Theine
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.entranceMawOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.entranceMawOnEventFinish(player, csid, option, npc)
end

return entity
