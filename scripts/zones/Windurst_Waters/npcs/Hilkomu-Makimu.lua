-----------------------------------
-- Area: Windurst Waters
--  NPC: Hilkomu-Makimu
-- Standard Merchant NPC
-- Confirmed shop stock, August 2013
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.HIKOMUMAKIMU_SHOP_DIALOG)

    stock = {
        4829, 23184, 1,     --Scroll of Poison II
        4839, 12880, 1,     --Scroll of Bio II
        4833,  4747, 1,     --Scroll of Poisonga

        4797,  1191, 2,     --Scroll of Stonega
        4807,  2143, 2,     --Scroll of Waterga
        4792,  4239, 2,     --Scroll of Aeroga
        4782,  7181, 2,     --Scroll of Firaga
        4787, 10948, 2,     --Scroll of Blizzaga
        4802, 15456, 2,     --Scroll of Thundaga
        4859,  8280, 2,     --Scroll of Shock Spikes

        4768,  5814, 3,     --Scroll of Stone II
        4778,  8100, 3,     --Scroll of Water II
        4763, 12236, 3,     --Scroll of Aero II
        4753, 16928, 3,     --Scroll of Fire II
        4758, 22356, 3,     --Scroll of Blizzard II
        4773, 28520, 3      --Scroll of Thunder II
    }
    tpz.shop.nation(player, stock, tpz.nation.WINDURST)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
