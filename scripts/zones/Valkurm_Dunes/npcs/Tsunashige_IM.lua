-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Tsunashige, I.M.
-- Outpost Conquest Guards
-- !pos 139.394 -7.885 100.384 103
-----------------------------------
local entity = {}

local guardNation = xi.nation.BASTOK
local guardType   = xi.conq.guard.OUTPOST
local guardRegion = xi.region.ZULKHEIM
local guardEvent  = 32761

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
