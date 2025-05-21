-----------------------------------
-- Area: Pashhow Marshlands [S]
--  NPC: Cavernous Maw
-- !pos 418 25 27 90
-- Teleports Players to Pashhow_Marshlands
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.maws.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.maws.onEventFinish(player, csid, option, npc)
end

return entity
