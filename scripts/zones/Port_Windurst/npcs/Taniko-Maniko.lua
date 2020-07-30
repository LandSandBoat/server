-----------------------------------
-- Area: Port Windurst
--  NPC: Taniko-Maniko
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        16649, 5864, 2,    -- Bone Pick
        16405,  104, 3,    -- Cat Baghnakhs
        16385,  129, 3,    -- Cesti
        16391, 1521, 3,    -- Brass Knuckles
        16407, 1521, 3,    -- Brass Baghnakhs
        16642, 4198, 3,    -- Bone Axe
        16768,  309, 3,    -- Bronze Zaghnal
        16769, 2542, 3,    -- Brass Zaghnal
        16832,   97, 3,    -- Harpoon
        16448,  143, 3,    -- Bronze Dagger
        16449,  837, 3,    -- Brass Dagger
        16450, 1827, 3,    -- Dagger
        16512, 3215, 3,    -- Bilbo
        16530,  618, 3,    -- Xiphos
        16565, 1674, 3,    -- Spatha
    }

    player:showText(npc, ID.text.TANIKOMANIKO_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.WINDURST)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
