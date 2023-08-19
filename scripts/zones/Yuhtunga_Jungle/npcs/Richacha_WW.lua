-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Richacha, W.W.
-- Border Conquest Guards
-- !pos -241.334 -1 478.602 123
-----------------------------------
local entity = {}

local guardNation = xi.nation.WINDURST
local guardType   = xi.conq.guard.BORDER
local guardRegion = xi.region.ELSHIMOLOWLANDS
local guardEvent  = 32758

entity.onTrade = function(player, npc, trade)
    xi.conq.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

entity.onTrigger = function(player, npc)
    xi.conq.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent, guardRegion)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.conq.overseerOnEventUpdate(player, csid, option, guardNation)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.conq.overseerOnEventFinish(player, csid, option, guardNation, guardType, guardRegion)
end

return entity
