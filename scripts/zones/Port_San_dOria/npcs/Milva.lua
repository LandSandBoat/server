-----------------------------------
-- Area: Port San d'Oria
--  NPC: Milva
-- Sarutabaruta Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.SARUTABARUTA) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.MILVA_CLOSED_DIALOG)
    else
        local stock =
        {
            4444, 22,    -- Rarab Tail
            689,  33,    -- Lauan Log
            619,  43,    -- Popoto
            4392, 29,    -- Saruta Orange
            635,  18,    -- Windurstian Tea Leaves
        }

        player:showText(npc, ID.text.MILVA_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
