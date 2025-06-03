-----------------------------------
-- Area: East Ronfaure [S]
--  NPC: Cavernous Maw
-- Teleports Players to East Ronfaure
-- !pos 322 -59 503 81
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
