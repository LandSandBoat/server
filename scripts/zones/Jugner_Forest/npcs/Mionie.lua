-----------------------------------
-- Area: Jugner Forest
--  NPC: Mionie
-- Type: Outpost Vendor
-- !pos 54 0 -11 104
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------

local vendorRegion  = tpz.region.NORVALLEN
local vendorEvent   = 32756

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.conquest.vendorOnTrigger(player, vendorRegion, vendorEvent)
end

function onEventUpdate(player, csid, option)
    tpz.conquest.vendorOnEventUpdate(player, vendorRegion)
end

function onEventFinish(player, csid, option)
    tpz.conquest.vendorOnEventFinish(player, option, vendorRegion)
end
