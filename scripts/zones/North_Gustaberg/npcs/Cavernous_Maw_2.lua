-----------------------------------
-- Area: North Gustaberg
--  NPC: Cavernous Maw
-- !pos -78.000 -0.500 600.000 106
-- Teleports Players to Abyssea - Grauberg
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
