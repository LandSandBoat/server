-----------------------------------
-- Area: Port Bastok
--  NPC: Numa
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12457, 5079, 1,    -- Cotton Hachimaki
        12585, 7654, 1,    -- Cotton Dogi
        12713, 4212, 1,    -- Cotton Tekko
        12841, 6133, 1,    -- Cotton Sitabaki
        12969, 3924, 1,    -- Cotton Kyahan
        13205, 3825, 1,    -- Silver Obi
        12456,  759, 2,    -- Hachimaki
        12584, 1145, 2,    -- Kenpogi
        12712,  630, 2,    -- Tekko
        12840,  915, 2,    -- Sitabaki
        12968,  584, 2,    -- Kyahan
        704,    132, 2,    -- Bamboo Stick
        605,    180, 3,    -- Pickaxe
        5867, 13500, 3,    -- Toolbag (Ino)
        5868, 18000, 3,    -- Toolbag (Shika)
        5869, 18000, 3,    -- Toolbag (Cho)
    }

    player:showText(npc, ID.text.NUMA_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
