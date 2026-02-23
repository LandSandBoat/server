-----------------------------------
-- Area: Abyssea - Grauberg
--  NPC: Cavernous Maw
-- !pos -564.000 30.300 -760.000 254
-- Teleports Players to North Gustaberg
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
