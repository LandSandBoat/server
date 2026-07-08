-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Cavernous Maw
-- !pos -344.396 -24.941 52.581 118
-- Teleports Players to Abyssea - Attohwa
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
