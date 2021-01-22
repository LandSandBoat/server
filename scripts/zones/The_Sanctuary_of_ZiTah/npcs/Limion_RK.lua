-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  NPC: Limion, R.K.
-- Border Conquest Guards
-- !pos -252.454 -1.958 624.366 121
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

local guardNation = tpz.nation.SANDORIA
local guardType   = tpz.conq.guard.BORDER
local guardRegion = tpz.region.LITELOR
local guardEvent  = 32762

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
