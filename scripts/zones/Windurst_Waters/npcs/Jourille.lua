-----------------------------------
-- Area: Windurst Waters
--  NPC: Jourille
-- Only sells when Windurst controlls Ronfaure Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local RegionOwner = GetRegionOwner(tpz.region.RONFAURE)
    if (RegionOwner ~= tpz.nation.WINDURST) then
        player:showText(npc, ID.text.JOURILLE_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.JOURILLE_OPEN_DIALOG)

        local stock =
        {
            639,   110,  -- Chestnut
            4389,   29,  -- San d'Orian Carrot
            610,    55,  -- San d'Orian Flour
            4431,   69,  -- San d'Orian Grape
        }
        tpz.shop.general(player, stock, WINDURST)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
