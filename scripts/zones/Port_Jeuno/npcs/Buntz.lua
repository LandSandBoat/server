-----------------------------------
-- Area: Port Jeuno
--  NPC: Buntz
-- Standard Info NPC
-----------------------------------
require('modules/custom/lua/era_custom_trades')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.customTrades.buntz(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:printToPlayer('Trade me a H. Kindred Crest, 3 Kindred\'s Seals, or 9 Beastmen\'s Seals for Kindred\'s Crests!!')
end

return entity
