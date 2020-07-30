-----------------------------------
-- Area: Bastok Markets
--  NPC: Oggodett
-- Aragoneu Regional Goods
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.ARAGONEU) ~= tpz.nation.BASTOK then
        player:showText(npc, ID.text.OGGODETT_CLOSED_DIALOG)
    else
        local stock =
        {
            631,    36,    -- Horo Flour
            629,    43,    -- Millioncorn
            4415,  111,    -- Roasted Corn
            4505,   90,    -- Sunflower Seeds
            841,    36,     -- Yagudo Feather
        }

        player:showText(npc, ID.text.OGGODETT_OPEN_DIALOG)
        tpz.shop.general(player, stock, BASTOK)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
