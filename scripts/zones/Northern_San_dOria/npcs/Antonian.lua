-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Antonian
-- Regional Marchant NPC
-- Only sells when San d'Oria controlls Aragoneu.
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.ARAGONEU) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.ANTONIAN_CLOSED_DIALOG)
    else
        local stock =
        {
            631,   36,    -- Horo Flour
            629,   43,    -- Millioncorn
            4415, 111,    -- Roasted Corn
            841,   36,    -- Yagudo Feather
            4505,  90,    -- Sunflower Seeds
        }

        player:showText(npc, ID.text.ANTONIAN_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
