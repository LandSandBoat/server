-----------------------------------
-- Area: Abyssea Altepa
--  NPC: Cavernous Maw
-- !pos 444.000 -0.500 320.000 218
-- Notes Teleports Players to South Gustaberg
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
