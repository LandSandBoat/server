-----------------------------------
-- Area: Abyssea - Tahrongi
--  NPC: Cavernous Maw
-- !pos -31.000 47.000 -681.000 45
-- Teleports Players to Tahrongi Canyon
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
