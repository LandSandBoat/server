-----------------------------------
-- Area: Abyssea - Attohwa
--  NPC: Cavernous Maw
-- !pos -133.197 20.242 -181.658 215
-- Notes: Teleports Players to Buburimu Peninsula
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
