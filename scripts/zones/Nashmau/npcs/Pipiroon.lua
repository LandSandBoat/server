-----------------------------------
-- Area: Nashmau
--  NPC: Pipiroon
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        17313, 1204,    -- Grenade
        17315, 6000,    -- Riot Grenade
        928,    515,    -- Bomb Ash
        2873, 10000,     -- Nashmau Waystone
    }

    player:showText(npc, ID.text.PIPIROON_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
