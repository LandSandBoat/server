-----------------------------------
-- Area: South Gustaberg
--  NPC: Cavernous Maw
-- !pos 340.000 -0.500 -680.000 107
-- Teleports Players to Abyssea - Altepa
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
