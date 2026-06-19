-----------------------------------
-- Area: RuLude_Gardens
--  NPC: HomePoint#3
-- !pos -67 6 -25 243
-----------------------------------
require('modules/custom/lua/homepoint_crystal_exchange')
-----------------------------------
---@type TNpcEntity
local entity = {}

local hpEvent = 8702
local hpIndex = 31

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
