-----------------------------------
-- Area: Windurst Waters
--  NPC: Shohrun-Tuhrun
-- Standard Merchant NPC
-- Confirmed shop stock, August 2013
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.SHOHRUNTUHRUN_SHOP_DIALOG)

    stock = {
        4665, 18000, 1,     --Haste

        4620,  5178, 2,     --Scroll of Raise
        4632, 10080, 2,     --Scroll of Dia II
        4637,  8100, 2,     --Scroll of Banish II
        4652,  6366, 2,     --Scroll of Protect II
        4657, 15840, 2,     --Scroll of Shell II
        4708,  4644, 2,     --Scroll of Enfire
        4709,  3688, 2,     --Scroll of Enblizzard
        4710,  2250, 2,     --Scroll of Enaero
        4711,  1827, 2,     --Scroll of Enstone
        4712,  1363, 2,     --Scroll of Enthunder
        4713,  6366, 2,     --Scroll of Enwater

        4611,  3261, 3,     --Scroll of Cure III
        4654, 78200, 3,     --Scroll of Protect IV
        4736, 74520, 3,     --Scroll of Protectra IV
        4868, 64400, 3      --Scroll of Dispel
    }
    tpz.shop.nation(player, stock, tpz.nation.WINDURST)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
