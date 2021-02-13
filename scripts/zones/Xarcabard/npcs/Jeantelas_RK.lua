-----------------------------------
-- Area: Xarcabard
--  NPC: Jeantelas, R.K.
-- Type: Outpost Conquest Guards
-- !pos 207.548 -24.795 -203.694 112
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

local guardNation = tpz.nation.SANDORIA
local guardType   = tpz.conq.guard.OUTPOST
local guardRegion = tpz.region.VALDEAUNIA
local guardEvent  = 32763

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
