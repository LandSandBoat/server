-----------------------------------
-- Area: Windurst Woods
--  NPC: Nya Labiccio
-- Only sells when Windurst controlls Gustaberg Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local RegionOwner = GetRegionOwner(tpz.region.GUSTABERG)
    if RegionOwner ~= tpz.nation.WINDURST then
        player:showText(npc, ID.text.NYALABICCIO_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.NYALABICCIO_OPEN_DIALOG)

        local stock =
        {
            1108,  703, -- Sulfur
            619,    43, -- Popoto
            611,    36, -- Rye Flour
            4388,   40  -- Eggplant
        }
        tpz.shop.general(player, stock, WINDURST)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
