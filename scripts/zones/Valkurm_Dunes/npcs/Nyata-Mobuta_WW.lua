-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Nyata-Mobuta, W.W.
-- Type: Outpost Conquest Guards
-- !pos 139.394 -7.885 100.384 103
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

local guardNation = tpz.nation.WINDURST
local guardType   = tpz.conq.guard.OUTPOST
local guardRegion = tpz.region.ZULKHEIM
local guardEvent  = 32759

entity.onTrade = function(player, npc, trade)
    tpz.conq.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

entity.onTrigger = function(player, npc)
    tpz.conq.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent, guardRegion)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.conq.overseerOnEventUpdate(player, csid, option, guardNation)
end

entity.onEventFinish = function(player, csid, option)
    tpz.conq.overseerOnEventFinish(player, csid, option, guardNation, guardType, guardRegion)
end

return entity
