-----------------------------------
-- Area: Davoi
--  NPC: Treasure Chest
-- !zone 149
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
