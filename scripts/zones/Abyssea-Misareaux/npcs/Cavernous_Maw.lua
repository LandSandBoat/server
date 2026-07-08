-----------------------------------
-- Area: Abyssea - Misareaux
--  NPC: Cavernous Maw
-- !pos 676.070 -16.063 318.999 216
-- Teleports Players to Valkrum Dunes
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.exitMawOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.exitMawOnEventFinish(player, csid, option, npc)
end

return entity
