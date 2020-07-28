-----------------------------------
-- Area: Port Bastok
--  NPC: Ilita
-- Linkshell Merchant
--   !pos -142 -1 -25 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/shop")


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        512,  6000,    -- Linkshell
        16285, 375,    -- Pendant Compass
    }

    player:showText(npc, ID.text.ILITA_SHOP_DIALOG, 513)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
