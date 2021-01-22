-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: Daruru, W.W.
-- Type: Border Conquest Guards
-- !pos -120.393 -25.822 -592.604 119
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

local guardNation = tpz.nation.WINDURST
local guardType   = tpz.conq.guard.BORDER
local guardRegion = tpz.region.ARAGONEU
local guardEvent  = 32758

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
