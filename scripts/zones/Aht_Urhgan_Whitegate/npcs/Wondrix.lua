-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Wondrix
-- ERA Custom NPC: Trades all 8 elemental grips for a Magic Strap
-----------------------------------
require('modules/custom/lua/elemental_grip_trade')
require('scripts/globals/npc_util')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.elementalGripTrade.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.elementalGripTrade.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
