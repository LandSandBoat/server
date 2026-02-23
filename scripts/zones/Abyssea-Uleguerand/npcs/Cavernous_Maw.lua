-----------------------------------
-- Area: Abyssea - Uleguerand
--  NPC: Cavernous Maw
-- !pos -246.000 -40.600 -520.000 253
-- Notes: Teleports Players to Xarcabard
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
