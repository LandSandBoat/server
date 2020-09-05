-----------------------------------
-- Area: Windurst Woods
--  NPC: Taraihi-Perunhi
-- Only sells when Windurst controlls Derfland Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/shop")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
    local RegionOwner = GetRegionOwner(tpz.region.DERFLAND)
    if RegionOwner ~= tpz.nation.WINDURST then
        player:showText(npc, ID.text.TARAIHIPERUNHI_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.TARAIHIPERUNHI_OPEN_DIALOG)

        local stock =
        {
            4352,  128, -- Derfland Pear
            617,   142, -- Ginger
            4545,   62, -- Gysahl Greens
            1412, 1656, -- Olive Flower
            633,    14, -- Olive Oil
            951,   110  -- Wijnruit
        }
        tpz.shop.general(player, stock, WINDURST)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
