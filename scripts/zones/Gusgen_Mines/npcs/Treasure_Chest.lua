-----------------------------------
-- Area: Gusgen Mines
--  NPC: Treasure Chest
-- Involved In Quest: The Goblin Tailor
-- !zone 196
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.treasure.onTrade(player, npc, trade, xi.treasure.type.CHEST)
end

entity.onTrigger = function(player, npc)
    xi.treasure.onTrigger(player, xi.treasure.type.CHEST)
end

return entity
