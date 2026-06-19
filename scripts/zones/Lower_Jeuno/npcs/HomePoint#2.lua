-----------------------------------
-- Area: Lower Jeuno
--  NPC: HomePoint#2
-- !pos 18 -1 54 245
-----------------------------------
require('modules/custom/lua/homepoint_crystal_exchange')
-----------------------------------
---@type TNpcEntity
local entity = {}

local hpEvent = 8701
local hpIndex = 36

entity.onTrigger = function(player, npc)
    xi.homepoint.onTrigger(player, hpEvent, hpIndex)
end

entity.onTrade = function(player, npc, trade)
    xi.homepointExchange.onTrade(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.homepoint.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.homepoint.onEventFinish(player, csid, option, hpEvent)
end

return entity
