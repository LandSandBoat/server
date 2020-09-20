-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Aveline
-- Standard Merchant NPC
-- !pos -139 -6 46 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        625,  79, 1,    -- Apple Vinegar
        623, 117, 1,    -- Bay Leaves
        4382, 28, 1,    -- Frost Turnip
        4392, 28, 1,    -- Saruta Orange
        4363, 39, 2,    -- Faerie Apple
        4366, 21, 2,    -- La Theine Cabbage
        633,  14, 3,    -- Olive Oil
        638, 166, 3,    -- Sage
        4389, 28, 3,    -- San d'Orian Carrot
        4431, 68, 3,    -- San d'Orian Grape
    }

    player:showText(npc, ID.text.AVELINE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
