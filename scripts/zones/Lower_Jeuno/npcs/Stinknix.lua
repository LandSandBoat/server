-----------------------------------
-- Area: Lower Jeuno
--  NPC: Stinknix
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        943,    294,    -- Poison Dust
        944,   1035,    -- Venom Dust
        945,   2000,    -- Paralysis Dust
        17320,    7,    -- Iron Arrow
        17336,    5,    -- Crossbow Bolt
        17313, 1107,    -- Grenade
        2865, 10000,    -- Dutchy Waystone
    }

    player:showText(npc, ID.text.STINKNIX_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
