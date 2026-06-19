-----------------------------------
-- Area: Port Jeuno
--  NPC: Karl
-- Starts and Finishes Quest: Child's Play
-- !pos -60 0.1 -8 246
-----------------------------------
require('modules/custom/lua/era_custom_trades')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.customTrades.karl(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:printToPlayer('Trade me a H. Kindred Crest, Kindred\'s Crest, or Kindred\'s Seal for Beastmen\'s Seals!!')
end

return entity
