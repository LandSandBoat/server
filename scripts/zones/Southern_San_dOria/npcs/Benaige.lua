-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Benaige
-- Standard Merchant NPC
-- !pos -142 -6 47 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        628,   234, 1,    -- Cinnamon
        629,    43, 1,    -- Millioncorn
        622,    43, 2,    -- Dried Marjoram
        610,    54, 2,    -- San d'Orian Flour
        627,    36, 2,    -- Maple Sugar
        1840, 1800, 2,    -- Semolina
        5726,  442, 2,    -- Zucchini
        5740,  511, 2,    -- Paprika
        621,    25, 3,    -- Crying Mustard
        611,    36, 3,    -- Rye Flour
        936,    14, 3,    -- Rock Salt
        4509,   10, 3,    -- Distilled Water
        5234,  198, 3,    -- Cibol
    }

    player:showText(npc, ID.text.BENAIGE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
