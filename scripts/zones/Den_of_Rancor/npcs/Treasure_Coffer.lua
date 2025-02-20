-----------------------------------
-- Area: Den of Rancor
--  NPC: Treasure Coffer
-- !zone 160
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.treasure.onTrade(player, npc, trade, xi.treasure.type.COFFER)
end

entity.onTrigger = function(player, npc)
    xi.treasure.onTrigger(player, xi.treasure.type.COFFER)
end

return entity
