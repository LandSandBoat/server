-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Cavernous Maw
-- !pos -28.000 46.000 -685.000 117
-- Teleports Players to Abyssea - Tahrongi
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
