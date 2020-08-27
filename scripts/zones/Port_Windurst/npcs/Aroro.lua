-----------------------------------
-- Area: Port Windurst
--  NPC: Aroro
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4862,  114, 1,    -- Blind
        4828,   84, 2,    -- Poison
        4838,  368, 2,    -- Bio
        4861, 2300, 2,    -- Sleep
        4767,   62, 3,    -- Stone
        4777,  143, 3,    -- Water
        4762,  331, 3,    -- Aero
        4752,  855, 3,    -- Fire
        4757, 1619, 3,    -- Blizzard
        4772, 3334, 3,    -- Thunder
        4843, 4747, 3,    -- Burn
        4844, 3770, 3,    -- Frost
        4845, 2300, 3,    -- Choke
        4846, 1867, 3,    -- Rasp
        4847, 1393, 3,    -- Shock
        4848, 6508, 3,    -- Drown
    }

    player:showText(npc, ID.text.ARORO_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.WINDURST)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
