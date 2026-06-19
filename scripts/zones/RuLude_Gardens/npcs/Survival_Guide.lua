-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Survival Guide
-- ERA Custom Trades
-----------------------------------
require('modules/custom/lua/era_custom_trades')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.customTrades.survivalGuide(player, npc, trade)
end

entity.onTrigger = function(player, targetNpc)
    xi.survivalGuide.onTrigger(player)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.survivalGuide.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.survivalGuide.onEventFinish(player, csid, option, npc)
end

return entity
