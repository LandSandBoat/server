-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Fighting Ant, I.M.
-- Border Conquest Guards
-- !pos 908.245 -1.171 -411.504 103
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------

local guardNation = tpz.nation.BASTOK
local guardType   = tpz.conq.guard.BORDER
local guardRegion = tpz.region.ZULKHEIM
local guardEvent  = 32760

function onTrade(player, npc, trade)
    tpz.conq.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

function onTrigger(player, npc)
    tpz.conq.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent, guardRegion)
end

function onEventUpdate(player, csid, option)
    tpz.conq.overseerOnEventUpdate(player, csid, option, guardNation)
end

function onEventFinish(player, csid, option)
    tpz.conq.overseerOnEventFinish(player, csid, option, guardNation, guardType, guardRegion)
end
