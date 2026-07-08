-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Cavernous Maw
-- !pos 95.344 -69.080 -580.008 108
-- Teleports Players to Abyssea - Konschtat
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
