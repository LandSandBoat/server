-----------------------------------
-- Area: Ordelles Caves
--  NPC: Treasure Chest
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.treasure.onTrade(player, npc, trade, 0, 0)
end

entity.onTrigger = function(player, npc)
    xi.treasure.onTrigger(player, npc)
end

return entity
