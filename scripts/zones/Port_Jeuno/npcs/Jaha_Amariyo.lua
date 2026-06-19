-----------------------------------
-- Area: Port Jeuno
--  NPC: Jaha Amariyo
-- Standard Info NPC
-----------------------------------
require('modules/custom/lua/era_custom_trades')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.customTrades.jahaAmariyo(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:printToPlayer('Trade me a H. Kindred Crest, Kindred\'s Crest, or 3 Beastmen\'s Seals for Kindred\'s Seals!!')
end

return entity
