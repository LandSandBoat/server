-----------------------------------
-- Area: Abyssea - Konschatat
--  NPC: Cavernous Maw
-- !pos 159.943 -72.109 -839.986 15
-- Teleports Players to Konschatat Highlands
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
