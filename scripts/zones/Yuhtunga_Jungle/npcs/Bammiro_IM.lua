-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Bammiro, I.M.
-- Border Conquest Guards
-- !pos -241.334 -1 478.602 123
-----------------------------------
---@type TNpcEntity
local entity = {}

local guardNation = xi.nation.BASTOK
local guardType   = xi.conquest.guard.BORDER
local guardRegion = xi.region.ELSHIMOLOWLANDS
local guardEvent  = 32760

entity.onTrade = function(player, npc, trade)
    xi.conquest.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

entity.onTrigger = function(player, npc)
    xi.conquest.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent, guardRegion)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.conquest.overseerOnEventUpdate(player, csid, option, guardNation)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.conquest.overseerOnEventFinish(player, csid, option, guardNation, guardType, guardRegion)
end

return entity
