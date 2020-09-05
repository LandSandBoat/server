-----------------------------------
-- Area: Lower Jeuno
--  NPC: Adelflete
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        806,   1863,    -- Tourmaline
        807,   1863,    -- Sardonyx
        800,   1863,    -- Amethyst
        814,   1863,    -- Amber
        795,   1863,    -- Lapis Lazuli
        809,   1863,    -- Clear Topaz
        799,   1863,    -- Onyx
        796,   1863,    -- Light Opal
        13327, 1250,    -- Silver Earring
        13456, 1250,    -- Silver Ring
    }

    player:showText(npc, ID.text.ADELFLETE_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
