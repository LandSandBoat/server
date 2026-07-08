-----------------------------------
-- Area: Jugner Forest
--  NPC: Cavernous Maw
-- !pos 246.318 -0.709 5.706 104
-- Teleports Players to Abyssea - Vunkerl
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
