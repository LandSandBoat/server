-----------------------------------
-- Area: Bastok Mines
--  NPC: Boytz
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4128, 4445, 1,    --Ether
        4151,  736, 2,    --Echo Drops
        4112,  837, 2,    --Potion
        17318,   3, 2,    --Wooden Arrow
        217,   900, 3,    --Brass Flowerpot
        605,   180, 3,    --Pickaxe
        4150, 2387, 3,    --Eye Drops
        4148,   290, 3,    --Antidote
        17320,   7, 3,    --Iron Arrow
        17336,   5, 3,     --Crossbow Bolt
    }

    local rank = getNationRank(tpz.nation.BASTOK)

    if (rank ~= 1) then
        table.insert(stock, 1022)    --Thief's Tools
        table.insert(stock, 3643)
        table.insert(stock, 3)
    end
    if (rank == 3) then
        table.insert(stock, 1023)    --Living Key
        table.insert(stock, 5520)
        table.insert(stock, 3)
    end

    player:showText(npc, ID.text.BOYTZ_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
