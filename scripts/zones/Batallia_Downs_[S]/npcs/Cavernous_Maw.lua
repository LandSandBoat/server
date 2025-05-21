-----------------------------------
-- Area: Batallia Downs [S]
--  NPC: Cavernous Maw
-- !pos -48 0 435 84
-- Teleports Players to Batallia Downs
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
