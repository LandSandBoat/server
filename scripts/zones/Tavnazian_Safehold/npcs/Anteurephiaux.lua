-----------------------------------
-- Area: Tavnazian Safehold
-- NPC: Anteurephiaux
-- ERA Custom Trades
-----------------------------------
require('modules/custom/lua/era_custom_trades')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.customTrades.anteurephiaux(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
