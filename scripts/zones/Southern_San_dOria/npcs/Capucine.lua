-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Capucine
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12473, 1904,    -- Poet's Circlet
        12608, 1288,    -- Tunic
        12601, 2838,    -- Linen Robe
        12736,  602,    -- Mitts
        12729, 1605,    -- Linen Cuffs
        12864,  860,    -- Slacks
        12857, 2318,    -- Linen Slops
        12992,  556,    -- Solea
        12985, 1495,    -- Holly Clogs
    }

    player:showText(npc, ID.text.CAPUCINE_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
