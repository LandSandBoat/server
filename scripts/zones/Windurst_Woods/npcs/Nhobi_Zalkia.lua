-----------------------------------
-- Area: Windurst_Woods
--  NPC: Nhobi Zalkia
-- Only sells when Windurst controlls Kuzotz Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/shop")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local RegionOwner = GetRegionOwner(tpz.region.KUZOTZ)
    if RegionOwner ~= tpz.nation.WINDURST then
        player:showText(npc, ID.text.NHOBI_ZALKIA_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.NHOBI_ZALKIA_OPEN_DIALOG)

        local stock =
        {
            916,   855,  -- Cactuar Needle
            4412,  299,  -- Thundermelon
            4491,  184   -- Watermelon
        }
        tpz.shop.general(player, stock, WINDURST)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
