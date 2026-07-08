-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Cavernous Maw
-- !pos 367.980 -0.443 -119.874 103
-- Teleports Players to Abyssea Misareaux
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
