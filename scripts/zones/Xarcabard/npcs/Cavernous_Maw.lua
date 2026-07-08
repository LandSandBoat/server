-----------------------------------
-- Area: Xarcabard
--  NPC: Cavernous Maw
-- !pos 270.000 -9.000 -70.000 112
-- Teleports Players to Abyssea - Uleguerand
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
