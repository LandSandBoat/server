-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pirvidiauce
-- Conquest depending medicine seller
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12986, 9180, 1,    --Chestnut Sabbots
        4128,  4445, 1,    --Ether
        4112,   837, 1,    --Potion
        17336,    6, 2,    --Crossbow bolt
        4151,   720, 2,    --Echo Drops
        12985, 1462, 2,    --Holly Clogs
        4148,   284, 3,    --Antidote
        12984,  111, 3,    --Ash Clogs
        219,    900, 3,    --Ceramic Flowerpot
        4150,  2335, 3,    --Eye Drops
        1774,  1984, 3,    --Red Gravel
        17318,    3, 3,    --Wooden Arrow
        2862,  9200, 3,    --Kingdom Waystone
    }

    player:showText(npc, ID.text.PIRVIDIAUCE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
