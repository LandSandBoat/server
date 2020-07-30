-----------------------------------
-- Area: Bastok Mines
--  NPC: Galzerio
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        13198, 19602, 1,    --Swordbelt
        17389,   486, 1,    --Bamboo Fishing Rod
        17396,     3, 2,    --Little Worm
        17390,   212, 2,    --Yew Fishing Rod
        13196, 10054, 3,    --Silver Belt
        17395,    10, 3,    --Lugworm
        17391,    64, 3,    --Willow Fishing Rod
        12600,   216, 3,    --Robe
        12728,   118, 3,    --Cuffs
        12856,   172, 3,    --Slops
        12984,   111, 3,    --Ash Clogs
        12464,  1742, 3,    --Headgear
        12592,  2470, 3,    --Doublet
        12720,  1363, 3,    --Gloves
        12848,  1899, 3,    --Brais
        12976,  1269, 3,    --Gaiters
    }

    player:showText(npc, ID.text.GELZERIO_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
