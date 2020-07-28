-----------------------------------
-- Area: Upper Jeuno
-- NPC: Champalpieu
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4365, 120,    -- Rolanberry
        17320,  7,    -- Iron Arrow
        17336,  5,    -- Crossbow Bolt
        605,  180,    -- Pickaxe
        5064, 567,    -- Wind Threnody
        5067, 420,    -- Water Threnody
    }

    player:showText(npc, ID.text.MP_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
