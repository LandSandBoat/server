-----------------------------------
-- Area: Upper Jeuno
-- NPC: Areebah
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        636,  119,    -- Chamomile
        951,  110,    -- Wijnruit
        948,   60,    -- Carnation
        941,   80,    -- Red Rose
        949,   96,    -- Rain Lily
        956,  120,    -- Lilac
        957,  120,    -- Amaryllis
        958,  120,    -- Marguerite
        2370, 520,    -- Flower Seeds
    }

    player:showText(npc, ID.text.MP_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
