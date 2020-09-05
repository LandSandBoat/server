-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ashene
-- Standard Merchant NPC
-- !pos 70 0 61 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        16455,  4309, 1,    -- Baselard
        16532, 16934, 1,    -- Gladius
        16545, 21067, 1,    -- Broadsword
        16576, 35769, 1,    -- Hunting Sword
        16524, 13406, 1,    -- Fleuret
        16450,  1827, 2,    -- Dagger
        16536,  7128, 2,    -- Iron Sword
        16566,  8294, 2,    -- Longsword
        16448,   140, 3,    -- Bronze Dagger
        16449,   837, 3,    -- Brass Dagger
        16531,  3523, 3,    -- Brass Xiphos
        16535,   241, 3,    -- Bronze Sword
        16565,  1674, 3,    -- Spatha
    }

    player:showText(npc, ID.text.ASH_THADI_ENE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
