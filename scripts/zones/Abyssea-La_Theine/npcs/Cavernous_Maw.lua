-----------------------------------
-- Area: Abyssea - La Theine
--  NPC: Cavernous Maw
-- !pos -480.009 0.000 799.927 132
-- Teleports Players to La Theine Plateau
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
