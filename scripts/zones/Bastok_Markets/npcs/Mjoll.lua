-----------------------------------
-- Area: Batok Markets
--  NPC: Mjoll
-- Standard Merchant NPC
-- !pos -318.902 -10.319 -178.087 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local stock =
    {
        17321,    16, 1, -- Silver Arrow
        17218, 14158, 1, -- Zamburak
        17298,   294, 1, -- Tathlum
        17318,     3, 2, -- Wooden Arrow
        17337,    22, 2, -- Mythril Bolt
        17320,     7, 3, -- Iron Arrow
        5069,    199, 3, -- Scroll of Dark Threnody
        5063,   1000, 3, -- Scroll of Ice Threnody
        17216,   165, 3, -- Light Crossbow
        17217,  2166, 3, -- Crossbow
        17336,     5, 3, -- Crossbow Bolt
    }

    player:showText(npc, ID.text.MJOLL_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
