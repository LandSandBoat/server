-----------------------------------
-- Area: Port Windurst
--  NPC: Drozga
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12432, 1493,    -- Faceguard
        12560, 2296,    -- Scale Mail
        12688, 1225,    -- Scale Fng. Gnt.
        12816, 1843,    -- Scale Cuisses
        12944, 1117,    -- Scale Greaves
        13192,  437,    -- Leather Belt
        13327, 1287,    -- Silver Earring
        13469, 1287,    -- Leather Ring
    }

    player:showText(npc, ID.text.DROZGA_SHOP_DIALOG)
    tpz.shop.general(player, stock, WINDURST)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
