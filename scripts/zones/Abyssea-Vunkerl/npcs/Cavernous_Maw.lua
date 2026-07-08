-----------------------------------
-- Area: Abyssea - Vunkerl
--  NPC: Cavernous Maw
-- !pos -360.000 -46.750 700.000 217
-- Notes: Teleports Players to Jugner Forest
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
