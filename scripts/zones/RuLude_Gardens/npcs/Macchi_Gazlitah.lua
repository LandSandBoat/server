-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Macchi Gazlitah
-- Standard Mechant NPC
-- TODO: Add support for occasional stock.
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        5703,    100,    -- Uleguerand Milk
        5684,    250,    -- Chalaimbille
        17905,   100,    -- Wormy Broth
        --[[
        5686,    800,    -- Cheese Sandwich
        5729,   3360,    -- Bavarois
        5718,   1300,    -- Cream Puff
        461,    5000,    -- Buffalo Milk Case
        5152,   1280,    -- Buffalo Meat
        4722,  31878,    -- Enfire II
        4723,  30492,    -- Enblizzard II
        4724,  27968,    -- Enaero II
        4725,  26112,    -- Enstone II
        4726,  25600,    -- Enthunder II
        4727,  33000,    -- Enwater II
        4850, 150000,    -- Refresh II
        ]]--
    }

    player:showText(npc, ID.text.MACCHI_GAZLITAH_SHOP_DIALOG1)
    tpz.shop.general(player, stock, JEUNO)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
