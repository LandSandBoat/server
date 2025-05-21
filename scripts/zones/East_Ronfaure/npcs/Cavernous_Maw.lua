-----------------------------------
-- Area: East Ronfaure
--  NPC: Cavernous Maw
-- !pos 322 -59 503 101
-- Teleports Players to East Ronfaure [S]
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
