-----------------------------------
-- Area: Lower Jeuno
--  NPC: Sweepstox
-- ERA Custom Chat Staff Trade
-----------------------------------
require('modules/custom/lua/chatoyant_staff_trade')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.chatStaffTrade.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.chatStaffTrade.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
