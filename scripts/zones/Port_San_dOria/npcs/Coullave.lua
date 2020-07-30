-----------------------------------
-- Area: Port San d'Oria
--  NPC: Coullave
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4128,  4445, 1,    -- Ether
        17313, 1107, 1,    -- Grenade
        4112,   837, 1,    -- Potion
        704,     96, 2,    -- Bamboo Stick
        4151,   736, 2,    -- Echo Drops
        12456,  552, 2,    -- Hachimaki
        12584,  833, 2,    -- Kenpogi
        12968,  424, 2,    -- Kyahan
        13327, 1125, 2,    -- Silver Earring
        12840,  666, 2,    -- Sitabaki
        12712,  458, 2,    -- Tekko
        4148,   290, 3,    -- Antidote
        4150,  2387, 3,    -- Eye Drops
        13469, 1150, 3,    -- Leather Ring
    }

    player:showText(npc, ID.text.COULLAVE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
