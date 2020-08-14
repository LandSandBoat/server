-----------------------------------
-- Area: Nashmau
--  NPC: Poporoon
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12952,   336,    -- Leather Highboots
        12953,  3438,    -- Lizard Ledelsens
        12954, 11172,    -- Studded Boots
        12955, 20532,    -- Cuir Highboots
    }

    player:showText(npc, ID.text.POPOROON_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
